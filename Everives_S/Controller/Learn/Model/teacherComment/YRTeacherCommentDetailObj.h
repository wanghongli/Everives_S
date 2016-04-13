//
//  YRTeacherCommentDetailObj.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/13.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YRTeacherCommentDetailObj : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, assign) NSInteger attitude;
@property (nonatomic, assign) NSInteger describe;
@property (nonatomic, assign) NSInteger quality;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, assign) NSInteger hide;//0不隐藏 1隐藏
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger tid;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, assign) NSInteger uid;
@end
