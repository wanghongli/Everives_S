//
//  YRTeacherDetailObj.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/6.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "YRTeacherCommentObj.h"
#import "YRTeacherPicsObj.h"
#import "YRTeacherPlaceObj.h"
@interface YRTeacherDetailObj : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, assign) NSInteger student;
@property (nonatomic, strong) YRTeacherCommentObj *comment;
@property (nonatomic, strong) NSArray *pics;
@property (nonatomic, strong) NSArray *place;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger cared;

@end
