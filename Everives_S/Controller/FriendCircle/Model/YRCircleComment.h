//
//  YRCircleComment.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface YRCircleComment : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger fid;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger sid;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *child;
@property (nonatomic, strong) NSString *name;
@end
