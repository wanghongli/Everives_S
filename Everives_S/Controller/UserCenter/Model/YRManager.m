//
//  YRManager.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRManager.h"
static YRManager* shareManagerInfo;
@implementation YRManager

+(YRManager *)shareManagerInfo
{
    @synchronized(self){
        if (shareManagerInfo == nil) {
            shareManagerInfo = [[YRManager alloc] init];
        }
    }
    return shareManagerInfo;
}

#pragma mark - 初始化User
-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"getUser" object:nil];
    }
    return self;
}
#pragma mark - 初始化User的观察者方法
-(void)notification:(NSNotification *)sender
{
    [YRManager shareManagerInfo].user = sender.object;
}
@end
