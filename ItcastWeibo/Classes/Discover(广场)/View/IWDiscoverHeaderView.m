//
//  IWDiscoverHeaderView.m
//  4期-微博
//
//  Created by MJ Lee on 14-5-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWDiscoverHeaderView.h"
#import "IWDiscoverGridView.h"

@interface IWDiscoverHeaderView()
@property (weak, nonatomic) UIImageView *topImageView;
@property (weak, nonatomic) IWDiscoverGridView *gridView;
@end

@implementation IWDiscoverHeaderView
+ (instancetype)headerView
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    frame.size.height = 180;
    self = [super initWithFrame:frame];
    if (self) {
        // 1.头部图片
        UIImageView *topImageView = [[UIImageView alloc] init];
        topImageView.image = [UIImage imageWithName:@"square_ad"];
        [self addSubview:topImageView];
        self.topImageView = topImageView;
        
        // 2.中间格子内容
        IWDiscoverGridView *gridView = [IWDiscoverGridView gridView];
        gridView.gridData = @[@"世界杯", @"英语退出高考", @"深圳暴雨", @"晚安"];
        [self addSubview:gridView];
        self.gridView = gridView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.头部图片
    CGFloat topX = IWSettingTableBorder + 2;
    CGFloat topY = IWSettingCellMargin;
    CGFloat topW = self.frame.size.width - 2 * topX;
    CGFloat topH = self.topImageView.image.size.height;
    self.topImageView.frame = CGRectMake(topX, topY, topW, topH);
    
    // 2.格子
    CGFloat gridX = IWSettingTableBorder;
    CGFloat gridY = CGRectGetMaxY(self.topImageView.frame) + IWSettingCellMargin;
    CGFloat gridW = self.frame.size.width - 2 * gridX;
    CGFloat gridH = self.frame.size.height - gridY - IWSettingCellMargin;
    self.gridView.frame = CGRectMake(gridX, gridY, gridW, gridH);
}

@end
