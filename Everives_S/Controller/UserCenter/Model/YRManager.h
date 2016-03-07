//
//  YRManager.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRUserStatus.h"
@interface YRManager : NSObject

@property (nonatomic, strong) YRUserStatus *user;

+(YRManager *)shareManagerInfo;

@end
