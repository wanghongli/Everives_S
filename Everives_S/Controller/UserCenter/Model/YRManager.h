//
//  YRManager.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRUserStatus.h"
#import "YRUserLocation.h"
@interface YRManager : NSObject

@property (nonatomic, strong) YRUserStatus *user;
@property (nonatomic,strong) YRUserLocation *userLocation;

+(YRManager *)shareManagerInfo;

@end
