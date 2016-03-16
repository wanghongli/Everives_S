//
//  YRUserStatus.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YRUserStatus : NSObject

@property (nonatomic, strong) NSString *addrTime;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *bg;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lng;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *peopleId;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *rongToken;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sign;

//好友属性
@property (nonatomic, assign) BOOL relation;
@end
