//
//  IWSearchBar.m
//  01-ItcastWeibo
//
//  Created by apple on 14-1-13.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWSearchBar.h"

@implementation IWSearchBar
/**
 *  init方法内部会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内容垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        // 背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        // 占位文字
        self.placeholder = @"搜索";
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        
        // 文本框左边的放大镜图片 selfbar_textfield_self_icon
        UIImageView *leftIcon = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        leftIcon.contentMode = UIViewContentModeCenter;
        leftIcon.bounds = CGRectMake(0, 0, 25, 25);
        self.leftView = leftIcon;
        
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

@end
