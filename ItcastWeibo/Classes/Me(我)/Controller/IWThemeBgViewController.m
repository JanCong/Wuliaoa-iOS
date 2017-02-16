//
//  IWThemeBgViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWThemeBgViewController.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"

@interface IWThemeBgViewController ()

@end

@implementation IWThemeBgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *theme = [IWSettingArrowItem itemWithTitle:@"主题"];
    group.items = @[theme];
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *bg = [IWSettingArrowItem itemWithTitle:@"背景"];
    group.items = @[bg];
}

@end
