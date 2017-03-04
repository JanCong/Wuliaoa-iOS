//
//  IWAccountTool.m
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWAccount.h"
#import "IWAccountTool.h"

#define IWAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation IWAccountTool
+ (void)saveAccount:(IWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:IWAccountFile];
}

+ (IWAccount *)account
{
    // 取出账号
    IWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:IWAccountFile];
    return account;
}
@end
