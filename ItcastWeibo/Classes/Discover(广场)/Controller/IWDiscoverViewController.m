//
//  IWDiscoverViewController.m
//  示例-ItcastWeibo
//
//  Created by MJ Lee on 14-5-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWDiscoverViewController.h"
#import "IWSearchBar.h"
#import "IWSettingArrowItem.h"
#import "IWSettingGroup.h"
#import "IWMoreViewController.h"
#import "IWDiscoverHeaderView.h"

@interface IWDiscoverViewController ()

@end

@implementation IWDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加搜索框
    IWSearchBar *search = [[IWSearchBar alloc] init];
    search.bounds = CGRectMake(0, 0, 305, 30);
    self.navigationItem.titleView = search;
    
    // 2.header
    self.tableView.tableHeaderView = [IWDiscoverHeaderView headerView];
    if (iOS7) {
        self.tableView.contentInset = UIEdgeInsetsZero;
    }
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *hot = [IWSettingArrowItem itemWithIcon:@"hot_status" title:@"热门微博" destVcClass:nil];
    hot.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    
    IWSettingArrowItem *find = [IWSettingArrowItem itemWithIcon:@"find_people" title:@"找人" destVcClass:nil];
    find.subtitle = @"名人、有意思的人尽在这里";
    
    group.items = @[hot, find];
}

- (void)setupGroup1
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *gameCenter = [IWSettingArrowItem itemWithIcon:@"game_center" title:@"游戏中心" destVcClass:nil];
    IWSettingArrowItem *near = [IWSettingArrowItem itemWithIcon:@"near" title:@"周边" destVcClass:nil];
    IWSettingArrowItem *app = [IWSettingArrowItem itemWithIcon:@"app" title:@"应用" destVcClass:nil];
    group.items = @[gameCenter, near, app];
}

- (void)setupGroup2
{
    IWSettingGroup *group = [self addGroup];
    
    IWSettingArrowItem *video = [IWSettingArrowItem itemWithIcon:@"video" title:@"视频" destVcClass:nil];
    IWSettingArrowItem *music = [IWSettingArrowItem itemWithIcon:@"music" title:@"音乐" destVcClass:nil];
    IWSettingArrowItem *movie = [IWSettingArrowItem itemWithIcon:@"movie" title:@"电影" destVcClass:nil];
    IWSettingArrowItem *cast = [IWSettingArrowItem itemWithIcon:@"cast" title:@"播客" destVcClass:nil];
    IWSettingArrowItem *more = [IWSettingArrowItem itemWithIcon:@"more" title:@"更多" destVcClass:[IWMoreViewController class]];
    
    group.items = @[video, music, movie, cast, more];
}

#pragma mark - 代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view.window endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view.window endEditing:YES];
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
