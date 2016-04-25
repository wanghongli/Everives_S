//
//  YRUserStatus.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import <MAMapKit/MAMapKit.h>
@interface YRUserStatus : MAPointAnnotation
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
@property (nonatomic, strong) NSString *peopleId;//身份证
@property (nonatomic, strong) NSString *realname;//真实姓名
@property (nonatomic, strong) NSString *rongToken;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, assign) NSString *frozenMoney;
@property (nonatomic, assign) NSInteger checked; //0  1 完成 2 失败
@property (nonatomic, assign) NSInteger push;//设置中通知状态
@property (nonatomic, assign) NSInteger show;//'隐私设置 0显示 1不显示距离 2不显示',
@property (nonatomic, assign) NSInteger first;  //第一个数为第一次分享  第二个数表示第一次充值； 11都操作过    10 分享过  01充值过  00没有分享
@property (nonatomic, assign) NSInteger gua; //刮刮卡次数
//@property (nonatomic, assign) NSInteger kind;//0学员1教练
@property (nonatomic, assign) NSInteger zhuan;//大转盘次数
//好友属性
@property (nonatomic, assign) BOOL relation;
@end