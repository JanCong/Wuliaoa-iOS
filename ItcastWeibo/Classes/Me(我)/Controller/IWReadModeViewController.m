//
//  IWReadModeViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWReadModeViewController.h"
#import "IWSettingCheckItem.h"
#import "IWSettingSwitchItem.h"
#import "IWSettingLabelItem.h"
#import "IWSettingCheckGroup.h"

@interface IWReadModeViewController ()

@end

@implementation IWReadModeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 添加组
    IWSettingCheckGroup *group = [IWSettingCheckGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    IWSettingCheckItem *with = [IWSettingCheckItem itemWithTitle:@"有图模式"];
    IWSettingCheckItem *without = [IWSettingCheckItem itemWithTitle:@"无图模式"];
    group.items = @[with, without];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingSwitchItem *show = [IWSettingSwitchItem itemWithTitle:@"显示缩略微博"];
    
    group.items = @[show];
}
@end
