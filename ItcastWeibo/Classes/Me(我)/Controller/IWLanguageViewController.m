//
//  IWLanguageViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWLanguageViewController.h"
#import "IWSettingCheckItem.h"
#import "IWSettingCheckGroup.h"
#import "IWSettingLabelItem.h"

@interface IWLanguageViewController ()

@end

@implementation IWLanguageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加组
    IWSettingCheckGroup *group = [IWSettingCheckGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    IWSettingCheckItem *sys = [IWSettingCheckItem itemWithTitle:@"跟随系统"];
    IWSettingCheckItem *simple = [IWSettingCheckItem itemWithTitle:@"简体中文"];
    IWSettingCheckItem *complex = [IWSettingCheckItem itemWithTitle:@"繁體中文"];
    IWSettingCheckItem *english = [IWSettingCheckItem itemWithTitle:@"English"];
    group.items = @[sys, simple, complex, english];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}

@end
