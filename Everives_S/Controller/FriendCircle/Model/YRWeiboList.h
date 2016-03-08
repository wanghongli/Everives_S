//
//  YRWeiboList.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface YRWeiboList : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSArray *comment;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) NSString *praise;
@property (nonatomic, strong) NSString *praised;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *uid;

@end
