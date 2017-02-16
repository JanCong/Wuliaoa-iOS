//
//  IWDiscoverGridView.h
//  4期-微博
//
//  Created by MJ Lee on 14-5-6.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IWDiscoverGridView : UIView
+ (instancetype)gridView;
@property (strong, nonatomic) NSArray *gridData;
@end
