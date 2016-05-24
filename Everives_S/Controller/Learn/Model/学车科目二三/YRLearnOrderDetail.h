//
//  YRLearnOrderDetail.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//  订单详情

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class YRLearnPartnerObj;

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
@property (nonatomic, strong) YRLearnPartnerObj *partner;
/**
 *  cancle是取消订单的状态 1都可以退款（还要判断状态，如果是已取消则不能退款），其他状态见model里面通知部分 cancleReplyer是取消订单的响应者id，比如A请求退款，B需要响应，那么此处为B的ID。
 */
@property (nonatomic, assign) NSInteger cancle; //500退款申请 501同意 502拒绝 503等待审核 504审核失败
@property (nonatomic, assign) NSInteger cancleReplyer;
@end
