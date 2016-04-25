//
//  YRTeacherOrder.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/30.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class YRLearnPartnerObj;

@interface YRTeacherOrder : NSObject
@property (nonatomic, strong) NSString *avatar; //头像
@property (nonatomic, strong) NSString *date; //日期
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *kind; //科目二 0 科目三 1
@property (nonatomic, strong) NSString *pname; //场地名字
@property (nonatomic, strong) NSString *price; //价格
@property (nonatomic, assign) NSInteger more; //表示多个时间段
@property (nonatomic, strong) YRLearnPartnerObj *partner;
@property (nonatomic, strong) NSString *status; //0未支付 1已支付，等待同伴一起拼 2已支付，等待去练车 3待评价 4已评价 5已取消',
@property (nonatomic, assign) NSInteger time;//时间段
@property (nonatomic, strong) NSString *tname;//教练名字
@end
