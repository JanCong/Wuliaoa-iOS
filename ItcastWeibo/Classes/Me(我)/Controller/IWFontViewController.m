//
//  IWFontViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWFontViewController.h"
#import "IWSettingCheckItem.h"
#import "IWSettingCheckGroup.h"
#import "IWSettingLabelItem.h"

@interface IWFontViewController ()
@end

@implementation IWFontViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加组
    IWSettingCheckGroup *group = [IWSettingCheckGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    IWSettingCheckItem *big = [IWSettingCheckItem itemWithTitle:@"大"];
    IWSettingCheckItem *middle = [IWSettingCheckItem itemWithTitle:@"中"];
    IWSettingCheckItem *small = [IWSettingCheckItem itemWithTitle:@"小"];
    group.items = @[big, middle, small];
    
    // 设置来源
    group.sourceItem = self.sourceItem;
}


@end
