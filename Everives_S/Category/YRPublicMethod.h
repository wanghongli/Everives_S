//
//  YRPublicMethod.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/5.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRPublicMethod : NSObject
/**
 *  通过整型数据转换为12：30：30  数据
 *
 *  @param timeInt 传入的整型数据
 *
 *  @return 返回时间
 */
+(NSString *)publicMethodAccodingIntMsgTurnToTimeString:(NSInteger)timeInt;

/**
 *  检查是否有网络
 *
 *  @return yes为有网络，no为未联网
 */
+(BOOL)checkNetworkIsAvailable;

/**
 *  修改用户资料
 *
 *  @param key   数据名称
 *  @param value 具体数据
 */
+(void)changeUserMsgWithKeys:(NSArray *)keys values:(NSArray *)values;

@end
