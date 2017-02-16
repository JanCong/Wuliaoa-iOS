//
//  IWMoreViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-4.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWMoreViewController.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"

@interface IWMoreViewController ()

@end

@implementation IWMoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *shop = [IWSettingArrowItem itemWithIcon:@"shop" title:@"精选商品" destVcClass:nil];
    IWSettingArrowItem *lottery = [IWSettingArrowItem itemWithIcon:@"lottery" title:@"彩票" destVcClass:nil];
    IWSettingArrowItem *food = [IWSettingArrowItem itemWithIcon:@"food" title:@"美食" destVcClass:nil];
    IWSettingArrowItem *car = [IWSettingArrowItem itemWithIcon:@"car" title:@"汽车" destVcClass:nil];
    IWSettingArrowItem *tour = [IWSettingArrowItem itemWithIcon:@"tour" title:@"旅游" destVcClass:nil];
    IWSettingArrowItem *news = [IWSettingArrowItem itemWithIcon:@"news" title:@"新浪新闻" destVcClass:nil];
    IWSettingArrowItem *recommend = [IWSettingArrowItem itemWithIcon:@"recommend" title:@"官方推荐" destVcClass:nil];
    IWSettingArrowItem *read = [IWSettingArrowItem itemWithIcon:@"read" title:@"读书" destVcClass:nil];
    
    group.items = @[shop, lottery, food, car, tour, news, recommend, read];
}

@end
