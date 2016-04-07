//
//  YRFMDBObj.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "YRQuestionObj.h"
@interface YRFMDBObj : NSObject

/**
 *  创建数据库
 */
+ (FMDatabase *)initFmdb;
/**
 *  顺序练习
 *
 *  @param type 0为科目一   1为科目四
 *
 */
+ (NSMutableArray *) getShunXuPracticeWithType:(NSInteger)type withFMDB:(FMDatabase *)db;
/**
 *  专题练习
 *
 *  @param type 0为科目一   1为科目二
 *  @param kind 不同的kind代表不同的题目
 *
 */
+ (NSMutableArray *) getPracticeWithType:(NSInteger)type withSearchMsg:(NSString*)search withFMDB:(FMDatabase *)db;
/**
 *  获取错误
 *
 *  @param type 0为科目一   1为科目二
 *  @param allAlready  yes 全部  no 顺序练习
 *
 */
+ (NSMutableArray *) getErrorPracticeWithType:(NSInteger)type withFMDB:(FMDatabase *)db withAlreadyType:(BOOL)allType;
/**
 *  获取已做过
 *
 *  @param type 0为科目一   1为科目二
 *  @param allAlready  yes 全部  no 顺序练习
 *
 */
+ (NSMutableArray *) getAlreadyPracticeWithType:(NSInteger)type withFMDB:(FMDatabase *)db withAlreadyType:(BOOL)allAlready;
/**
 *  修改数据库的数据
 *
 *  @param msgID  题id
 *  @param newMsg 需要修改的数据
 *
 */
+ (void) changeMsgWithId:(NSInteger) msgID withNewMsg:(NSString *)newMsg withFMDB:(FMDatabase *)db;
/**
 *  获取错误题数、已做过题数和总题数
 *
 */
+(NSArray *)getErrorAlreadyAndTotalQuestionWithType:(NSInteger)type already:(BOOL)alreadyBool;
/**
 *  收藏
 *
 *  @param collectId 题id
 *  @param type      0表示科目一 1表示科目二
 */
+(void)setCollectId:(NSInteger)collectId withType:(NSInteger)type;
/**
 *  顺序练习获取最新做题的id
 *
 */
+(NSInteger) getCurrentQuestionIDWithType:(BOOL)type;
//创建沙盒存入数据或沙盒路径已有存入数据
+(void)saveMsgWithMsg:(NSInteger)msgString withType:(BOOL)type;
@end
