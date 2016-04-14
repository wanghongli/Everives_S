//
//  YRLearnOrderDetail.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//  订单详情

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface YRLearnOrderDetail : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, assign) NSInteger frozenMoney;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSArray *info;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, assign) NSInteger money;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger tid;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) NSString *tname;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger partner;
@end
