//
//  YRTeacherDetailObject.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/29.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YRTeacherDetailObject : NSObject
@property (nonatomic, strong) NSString *avatar;//头像
@property (nonatomic, assign) NSInteger grade; //评分
@property (nonatomic, strong) NSString *intro;//简介
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger kind;//科目
@property (nonatomic, strong) NSString *name;//姓名
@property (nonatomic, strong) NSString *student;//学生数量
@property (nonatomic, strong) NSString *year;//教龄
@end
