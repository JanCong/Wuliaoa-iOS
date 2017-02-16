//
//  IWIconQualityViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWIconQualityViewController.h"
#import "IWSettingLabelItem.h"
#import "IWSettingCheckItem.h"
#import "IWSettingCheckGroup.h"

@interface IWIconQualityViewController ()

@end

@implementation IWIconQualityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroupWithHeader:(NSString *)header
{
    // 添加组
    IWSettingCheckGroup *group = [IWSettingCheckGroup group];
    group.header = header;
    [self.groups addObject:group];
    
    // 设置数据
    IWSettingCheckItem *high = [IWSettingCheckItem itemWithTitle:@"高清"];
    high.subtitle = @"(建议在wifi或3G网络使用)";
    IWSettingCheckItem *normal = [IWSettingCheckItem itemWithTitle:@"普通"];
    normal.subtitle = @"(上传速度快，省流量)";
    group.items = @[high, normal];
    
    IWSettingLabelItem *item = [IWSettingLabelItem item];
    item.key = group.header;
    item.defaultText = high.title;
    group.sourceItem = item;
}

- (void)setupGroup0
{
    [self setupGroupWithHeader:@"上传图片质量"];
}

- (void)setupGroup1
{
    [self setupGroupWithHeader:@"下载图片质量"];
}

@end
