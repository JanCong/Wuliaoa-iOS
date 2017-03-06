//
//  IWMeViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWMeViewController.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWSystemSettingViewController.h"
#import "IWAccount.h"
#import "IWWeiboTool.h"
#import "IWAccountTool.h"
#import "IWOAuthViewController.h"

@interface IWMeViewController ()
@end

@implementation IWMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 先判断有无存储账号信息
    IWAccount *account = [IWAccountTool account];
    
    if (account) { // 之前登录成功
//        [IWWeiboTool chooseRootController];
    } else { // 之前没有登录成功
//        [IWWeiboTool chooseRootController];
//        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        [self.window makeKeyAndVisible];
//        self.window.rootViewController = [[IWOAuthViewController alloc] init];
        
        IWOAuthViewController *OAuthView = [[IWOAuthViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:OAuthView];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
//
//    [self setupGroup0];
//    [self setupGroup1];
//    [self setupGroup2];
//    [self setupGroup3];
}


/**
 *  设置
 */
- (void)setting
{
    IWSystemSettingViewController *sys = [[IWSystemSettingViewController alloc] init];
    [self.navigationController pushViewController:sys animated:YES];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *newFriend = [IWSettingArrowItem itemWithIcon:@"new_friend" title:@"新的好友" destVcClass:nil];
    newFriend.badgeValue = @"4";
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *album = [IWSettingArrowItem itemWithIcon:@"album" title:@"我的相册" destVcClass:nil];
    album.subtitle = @"(109)";
    IWSettingArrowItem *collect = [IWSettingArrowItem itemWithIcon:@"collect" title:@"我的收藏" destVcClass:nil];
    collect.subtitle = @"(0)";
    IWSettingArrowItem *like = [IWSettingArrowItem itemWithIcon:@"like" title:@"赞" destVcClass:nil];
    like.badgeValue = @"1";
    like.subtitle = @"(35)";
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *pay = [IWSettingArrowItem itemWithIcon:@"pay" title:@"微博支付" destVcClass:nil];
    IWSettingArrowItem *vip = [IWSettingArrowItem itemWithIcon:@"vip" title:@"会员中心" destVcClass:nil];
    group.items = @[pay, vip];
}

- (void)setupGroup3
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *card = [IWSettingArrowItem itemWithIcon:@"card" title:@"我的名片" destVcClass:nil];
    IWSettingArrowItem *draft = [IWSettingArrowItem itemWithIcon:@"draft" title:@"草稿箱" destVcClass:nil];
    group.items = @[card, draft];
}

@end
