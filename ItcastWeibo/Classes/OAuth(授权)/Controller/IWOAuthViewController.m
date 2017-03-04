//
//  IWOAuthViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWOAuthViewController.h"
#import "AFNetworking.h"
#import "IWAccount.h"
#import "IWWeiboTool.h"
#import "MBProgressHUD+MJ.h"
#import "IWAccountTool.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#define FitWidth 1
#define FitHeight 1 
@interface IWOAuthViewController () <UIWebViewDelegate,UITextFieldDelegate>
@property(nonatomic, assign)NSInteger keyboardHeight;
@property(nonatomic, assign)BOOL keyboardIsShow;
@property(nonatomic, strong)UITextField *userTextField;
@property(nonatomic, strong)UITextField *passTextField;
@property(nonatomic, strong)UIButton *loginButton;
@property(nonatomic, strong)UIImageView *userInputBackImageView;
@property(nonatomic, strong)UIImageView *passwordInputBackImageView;
@end

@implementation IWOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.76 green:0.64 blue:0.49 alpha:1];

    
    //图标
    UIImageView *iconIamgeView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 255/4 * FitWidth, 80 * FitHeight, 255/2 * FitWidth, 269/2 * FitHeight)];
    iconIamgeView.image = [UIImage imageNamed:@"common_button_red"];
    [self.view addSubview:iconIamgeView];
    //名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconIamgeView.frame.origin.x, iconIamgeView.frame.origin.y + iconIamgeView.frame.size.height, iconIamgeView.frame.size.width, 40 * FitHeight)];
    nameLabel.text = @"辣条";
    nameLabel.font = [UIFont systemFontOfSize:25];
    nameLabel.textAlignment = 1;
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    //用户名
    UIImageView *userBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(70 * FitWidth, nameLabel.frame.origin.y + nameLabel.frame.size.height + 100 * FitHeight, 526/2 * FitWidth, 92/2 * FitHeight)];
    userBackImageView.userInteractionEnabled = YES;
    userBackImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [self.view addSubview:userBackImageView];
    
    _userInputBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * FitWidth, 5 * FitHeight, 499/2 * FitWidth, 70/2 * FitHeight)];
    _userInputBackImageView.userInteractionEnabled = YES;
    _userInputBackImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [userBackImageView addSubview:_userInputBackImageView];
    _userInputBackImageView.hidden = YES;
    
    
    UIImageView *userIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10 * FitWidth, 8 * FitHeight, 56/2 * FitWidth, 56/2 * FitWidth)];
    userIconImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [userBackImageView addSubview:userIconImageView];
    
    _userTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, userBackImageView.frame.size.width, userBackImageView.frame.size.height)];
    [userBackImageView addSubview:_userTextField];
    
    //密码
    UIImageView *passwordBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(userBackImageView.frame.origin.x, userBackImageView.frame.origin.y + userBackImageView.frame.size.height + 20 * FitHeight, userBackImageView.frame.size.width, userBackImageView.frame.size.height)];
    passwordBackImageView.userInteractionEnabled = YES;
    passwordBackImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [self.view addSubview:passwordBackImageView];
    
    _passwordInputBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * FitWidth, 5 *FitHeight, 499/2 * FitWidth, 70/2 * FitHeight)];
    _passwordInputBackImageView.userInteractionEnabled = YES;
    _passwordInputBackImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [passwordBackImageView addSubview:_passwordInputBackImageView];
    _passwordInputBackImageView.hidden = YES;
    
    UIImageView *passwordIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(userIconImageView.frame.origin.x, userIconImageView.frame.origin.y, userIconImageView.frame.size.width, userIconImageView.frame.size.height)];
    passwordIconImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [passwordBackImageView addSubview:passwordIconImageView];
    
    _passTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, passwordBackImageView.frame.size.width, passwordBackImageView.frame.size.height)];
    _passTextField.secureTextEntry = YES;
    [passwordBackImageView addSubview:_passTextField];
    //单位识别码
    UIImageView *unitBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(passwordBackImageView.frame.origin.x, passwordBackImageView.frame.origin.y + passwordBackImageView.frame.size.height + 20 * FitHeight, passwordBackImageView.frame.size.width, passwordBackImageView.frame.size.height)];
    unitBackImageView.userInteractionEnabled = YES;
    unitBackImageView.image = [UIImage imageNamed:@"common_button_big_red_disable"];
    [self.view addSubview:unitBackImageView];
    
    //登录
    _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginButton.frame = CGRectMake(unitBackImageView.frame.origin.x - 10 * FitWidth, unitBackImageView.frame.origin.y + passwordBackImageView.frame.size.height + 20 * FitHeight, unitBackImageView.frame.size.width, unitBackImageView.frame.size.height);
    _loginButton.backgroundColor = [UIColor colorWithRed:0.59 green:0.42 blue:0.24 alpha:1];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 25 * FitWidth;
    [_loginButton setTitleColor:[UIColor colorWithRed:0.94 green:0.76 blue:0.48 alpha:1] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(loginBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    
    //键盘监听
    _keyboardIsShow = NO;
    //键盘出现或改变时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘退出时收到消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 输入框
    _userTextField.delegate = self;
    _passTextField.delegate = self;
    
    _userTextField.placeholder = @"用户名";
    _passTextField.placeholder = @"密码";
    
    _userTextField.textColor = [UIColor whiteColor];
    _passTextField.textColor = [UIColor whiteColor];
    
    _userTextField.textAlignment = NSTextAlignmentCenter;
    _passTextField.textAlignment = NSTextAlignmentCenter;
    
    //指定编辑时键盘的return键类型
    _userTextField.returnKeyType = UIReturnKeyNext;
    _passTextField.returnKeyType = UIReturnKeyNext;
    
    //注册键盘响应事件方法
    [_userTextField addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [_passTextField addTarget:self action:@selector(nextOnKeyboard:) forControlEvents:UIControlEventEditingDidEndOnExit];
  
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userNameStr = [defaults objectForKey:@"UserName"];
    NSString *passwordStr = [defaults objectForKey:@"Password"];
    
    _passTextField.text = passwordStr;
    _userTextField.text = userNameStr;

    
}

#pragma mark - keyboard
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyboardHeight = keyboardRect.size.height;
    _keyboardIsShow = YES;
    NSLog(@"keyboardHeight --- >%ld", _keyboardHeight);
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    _keyboardIsShow = NO;
}
#pragma mark - textField
-(void) resumeView
{
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame=rect;
    [UIView commitAnimations];
}
//点击键盘上的Return按钮响应的方法
-(void)nextOnKeyboard:(UITextField *)sender
{
    if (sender == _userTextField) {
        [_passTextField becomeFirstResponder];
    }else {
        [self hidenKeyboard];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_userTextField resignFirstResponder];
    [_passTextField resignFirstResponder];
}
//隐藏键盘的方法
-(void)hidenKeyboard
{
    [self.passTextField resignFirstResponder];
    [self.userTextField resignFirstResponder];
    [self resumeView];
}
#pragma mark - protocol
//textFieldProtocol
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == _userTextField) {
        _userInputBackImageView.hidden = NO;
    }else if (textField == _passTextField){
        _passwordInputBackImageView.hidden = NO;
    }
    
    
    NSTimeInterval animationDuration = 0.3f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    CGRect textFieldFrame = [textField convertRect:textField.frame toView:self.view];
    // 上移
    if (_keyboardIsShow) {
        float y = self.view.frame.origin.y;
        if (height - textFieldFrame.origin.y - y - _keyboardHeight > 90) {
            return YES;
        }
        CGRect rect = CGRectMake(0.0f, y - textField.frame.size.height, width, height);
        self.view.frame = rect;
    } else {
        
        int offset = textFieldFrame.origin.y + 90 - (height - 270);
        NSLog(@"offset --- >%d",offset);
        CGRect rect = CGRectMake(0.0f, - offset, width, height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
    
    return YES;
    
}

#pragma mark 登录方法
- (void)loginBtnAction:(id)sender{
    [self hidenKeyboard];
    
    NSString *userNameStr = _userTextField.text;
    NSString *passwordStr = _passTextField.text;
    
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"phone"] = userNameStr;
    params[@"password"] = passwordStr;
    params[@"device"] = [IWWeiboTool iphoneType];

    // 3.发送请求
    [mgr POST:IWLoginURl parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          IWAccount *account = [IWAccount mj_objectWithKeyValues:responseObject[@"result"]];
          if (account.nickname != nil) {
              [MBProgressHUD showSuccess:@"登录成功"];
              [IWAccountTool saveAccount:account];
              [IWWeiboTool chooseRootController];
          }else{
              [MBProgressHUD showSuccess:@"登录失败"];
          }
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showSuccess:@"发送失败"];
      }];
}



#pragma mark - webView代理方法
/**
 *  webView开始发送请求的时候就会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 显示提醒框
    [MBProgressHUD showMessage:@"哥正在帮你加载中..."];
}

/**
 *  webView请求完毕的时候就会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}
/**
 *  webView请求失败的时候就会调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // 隐藏提醒框
    [MBProgressHUD hideHUD];
}

/**
 *  当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 *
 *  @return YES : 可以加载页面,  NO : 不可以加载页面
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.请求的URL路径: http://ios.itcast.cn/?code=0f189b682cd020e79303dbb043d4fb28
    NSString *urlStr = request.URL.absoluteString;
    
    // 2.查找code=在urlStr中的范围
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 3.如果urlStr中包含了code=
    //    if (range.location != NSNotFound)
    if (range.length) {
        // 4.截取code=后面的请求标记(经过用户授权成功的)
        unsigned long loc = range.location + range.length;
        NSString *code = [urlStr substringFromIndex:loc];
        
        // 5.发送POST请求给新浪,  通过code换取一个accessToken
        [self accessTokenWithCode:code];
        
        // 不加载这个请求
        return NO;
    }
    
    return YES;
}

/**
 *  通过code换取一个accessToken
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = IWAppKey;
    params[@"client_secret"] = IWAppSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = IWRedirectURI;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          // 4.先将字典转为模型
          IWAccount *account = [IWAccount accountWithDict:responseObject];
          
          // 5.存储模型数据
          [IWAccountTool saveAccount:account];
          
          // 6.新特性\去首页
          [IWWeiboTool chooseRootController];
          
          // 7.隐藏提醒框
          [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 隐藏提醒框
        [MBProgressHUD hideHUD];
    }];
}

@end
