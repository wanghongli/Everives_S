//
//  YRMapFMDB.h
//  Everives_S
//
//  Created by darkclouds on 16/4/12.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface YRMapFMDB : NSObject
/**
 *  创建数据库
 */
+ (void)initFmdb;

/**
 *  插入数据
 *
 *  @param objArry 场地数组
 */
+ (void)saveObjects:(NSArray*)objArry;

/**
 *  读取数据
 *
 *  @return 场地数组
 */
+(NSArray*)GetSchools;
@end
