//
//  YRTeacherCommentObj.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/6.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface YRTeacherCommentObj : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger hide;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSArray *pics;
@end
