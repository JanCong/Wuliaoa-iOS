//
//  IWComposeViewController.m
//  ItcastWeibo
//
//  Created by MJ Lee on 14-5-18.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWComposeViewController.h"
#import "IWPlaceholderTextView.h"
#import "IWComposeToolbar.h"
#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWWeiboTool.h"
//选择相册
#import "LHGroupViewController.h"
#import "LHCollectionViewController.h"
#import "LHConst.h"
@interface IWComposeViewController () <IWComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) IWComposeToolbar *toolbar;
@property (weak, nonatomic) UIImageView *imageView;
@property (nonatomic,strong) NSMutableArray *imageArray;//存放处理完的图片
@property (nonatomic,strong) UIScrollView *scrolView;//滚动视图
@property (nonatomic,strong) NSMutableArray *scrollSubViews;//存放图片子视图
@property (nonatomic,strong) NSMutableArray *scrollSubFrame;//子视图的frame
@property (nonatomic,strong) NSMutableArray *localLength;//每张图片的尺寸
@end

@implementation IWComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageArray = [NSMutableArray new];
    self.scrollSubViews = [NSMutableArray new];
    self.scrollSubFrame = [NSMutableArray new];
    self.localLength = [NSMutableArray new];
    [self setupNavBar];
    [self setupTextView];
    [self setupToolbar];
    [self setupImageView];
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 100, 100, 100);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds = YES;
    [self.textView addSubview:imageView];
    self.imageView = imageView;
//    UIScrollView *scrol = [[UIScrollView alloc]init];
//    scrol.frame = CGRectMake(0, 100*(SCREEN_HEIGHT/568)+ 64, 320*(SCREEN_WIDTH/320), 77*(SCREEN_HEIGHT/568));
//    [self.textView addSubview:scrol];
//    self.scrolView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.scrolView = scrol;
//    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupToolbar
{
    IWComposeToolbar *toolbar = [[IWComposeToolbar alloc] init];
    toolbar.delegate = self;
    CGFloat toolbarH = 44;
    CGFloat toolbarW = self.view.frame.size.width;
    CGFloat toolbarY = self.view.frame.size.height - toolbarH;
    toolbar.frame = CGRectMake(0, toolbarY, toolbarW, toolbarH);
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)setupTextView
{
    IWPlaceholderTextView *textView = [[IWPlaceholderTextView alloc] init];
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [center addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:textView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)textDidChange:(NSNotification *)note
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length != 0;
}

- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 0.取出键盘动画的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"发无聊图";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)send
{
    if (self.imageView.image) {
        [self sendStatusWithImage];
    } else {
        [self sendStatusWithoutImage];
    }
    
    // 关闭
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendStatusWithoutImage
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @6;
    params[@"content"] = self.textView.text;
    params[@"device"] = [IWWeiboTool iphoneType];
    // 3.发送请求
    [mgr POST:IWArticleURL parameters:params
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    }
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"发送成功"];
          //通知首页刷新
          [[NSNotificationCenter defaultCenter] postNotificationName:PROBE_DEVICES_CHANGED object:nil];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showSuccess:@"发送失败"];
      }];
}

- (void)sendStatusWithImage
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = @6;
    params[@"content"] = self.textView.text;
    params[@"device"] = [IWWeiboTool iphoneType];
    
    // 3.发送请求
    [mgr POST:IWArticleURL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 0.1);
        [formData appendPartWithFileData:data name:@"images" fileName:@"" mimeType:@"image/jpeg"];
    }
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"发送成功"];
          //通知首页刷新
          [[NSNotificationCenter defaultCenter] postNotificationName:PROBE_DEVICES_CHANGED object:nil];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showSuccess:@"发送失败"];
      }];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - toolbar代理
- (void)composeToolbar:(IWComposeToolbar *)toolbar didClickedButton:(IWComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case IWComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case IWComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        default:
            break;
    }
}

/**
 *  照相机
 */
- (void)openCamera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  相册
 */
- (void)openAlbum
{
    [self acquireLocal];
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    ipc.delegate = self;
//    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark --
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info {
    __block UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    __weak IWComposeViewController *weakSelf = self;
    void(^imageBlock)() = ^(UIImage *image){
        __strong IWComposeViewController *strongSelf = weakSelf;
        if (!image) {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        NSString *length  = [NSString stringWithFormat:@"%f*%f",image.size.width,image.size.height];
        [strongSelf.localLength addObject:length];
        [strongSelf.imageArray addObject:image];
    };
    void(^dismissBlock)() = ^(){//声明
        __strong IWComposeViewController *strongSelf = weakSelf;
        [picker dismissViewControllerAnimated:YES completion:^{
            [strongSelf setSpread];
        }];
    };
    //写入本地
    [[LHPhotoList sharePhotoTool]saveImageToAblum:originalImage completion:^(BOOL success, PHAsset *asset) {
        if (success) {//存成功
            [[LHPhotoList sharePhotoTool]requestImageForAsset:asset size:CGSizeMake(1080, 1920) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
                originalImage = [UIImage imageWithData:UIImageJPEGRepresentation(originalImage, 1) scale:originalImage.scale];
                imageBlock(originalImage);
                dismissBlock();
            }];
        }else{//存取失败
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                originalImage = [UIImage imageWithData:UIImageJPEGRepresentation(originalImage, 1) scale:originalImage.scale];
                imageBlock(originalImage);
                dispatch_sync(dispatch_get_main_queue(), ^{
                    dismissBlock();
                });
            });
        }
    }];
}

#pragma mark --
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -获取本地图片
-(void)acquireLocal{
    LHGroupViewController *group = [[LHGroupViewController alloc]init];
    group.maxChooseNumber = 80;
    __weak IWComposeViewController *weakSelf = self;
    group.backImageArray = ^(NSMutableArray<PHAsset *> *array){
        __strong IWComposeViewController *strongSelf = weakSelf;
        if (array) {
            for (int i = 0; i<array.count; i++) {
                PHAsset *asset = array[i];
                [[LHPhotoList sharePhotoTool]requestImageForAsset:asset size:CGSizeMake(1080, 1920) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
                    NSString *length  = [NSString stringWithFormat:@"%f*%f",image.size.width,image.size.height];
                    [_localLength addObject:length];
                    [_imageArray addObject:image];
                    [strongSelf setSpread];
                }];
            }
        }
    };
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:group] animated:YES completion:nil];
}

#pragma mark -展示UI在界面
-(void)setSpread{
    self.imageView.image = self.imageArray[0];
    self.scrolView.contentSize = CGSizeMake((imageWidth+10)*self.imageArray.count, 77*(SCREEN_HEIGHT/568));
    for (NSInteger i = self.scrollSubViews.count; i<self.imageArray.count; i++) {
        UIView *itemView = [[UIView alloc]init];
        itemView.frame = CGRectMake(imageWidth*i+10*i, 5, imageWidth, imageWidth);
        itemView.backgroundColor = [UIColor whiteColor];
        [self.scrolView addSubview:itemView];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(0, 0, imageWidth, imageWidth);
        imageView.image = self.imageArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = 100 +i;
        [itemView addSubview:imageView];
        //手势
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(imageWidth - 17 , -5, 22, 22);
        deleteBtn.tag = 200+i;
        NSString *strDelete = [[NSBundle mainBundle]pathForResource:@"02" ofType:@"png"];
        [deleteBtn setImage:[UIImage imageWithContentsOfFile:strDelete] forState:UIControlStateNormal];//正常显示
        [deleteBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];//删除
        [itemView addSubview:deleteBtn];
        
        [self.scrollSubFrame addObject:[NSValue valueWithCGRect:itemView.frame]];
        [self.scrollSubViews addObject:itemView];
        [UIView animateWithDuration:0.2 animations:^{
            itemView.alpha = 1;
        } completion:nil];
    }
    
}

#pragma mark -删除图片
-(void)deleteImage:(UIButton *)btn{
    UIView *view  = btn.superview;
    NSInteger idx = [_scrollSubViews indexOfObject:view];
    [_scrollSubViews removeObject:view];
    [_imageArray removeObjectAtIndex:idx];
    [_localLength removeObjectAtIndex:idx];
    [_scrollSubFrame removeLastObject];
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        self.scrolView.contentSize = CGSizeMake(imageWidth*self.scrollSubViews.count, imageWidth);
        [UIView animateWithDuration:0.2 animations:^{
            for (NSInteger i = idx; i < self.scrollSubViews.count; i++) {
                UIView *item = self.scrollSubViews[i];
                item.frame = [(NSValue*)(self.scrollSubFrame[i]) CGRectValue];
            }
        } completion:^(BOOL finished) {
            if (finished) {
                //完成之后处理的code
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
