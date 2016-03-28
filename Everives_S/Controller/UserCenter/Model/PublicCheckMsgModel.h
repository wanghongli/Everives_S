//
//  PublicCheckMsgModel.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicCheckMsgModel : NSObject

//+(void)checkPhoneNub:(NSString *)phoneNub andPassword:(NSString *)password complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock;

/**
 *  检查登陆时的手机号码和密码
 *
 *  @param phoneNum      手机号码
 *  @param pswMsg        密码
 *  @param completeBlock 完成回调
 *  @param errorBlock    错误信息
 */
+ (void)loginMsgCheckTell:(NSString *)phoneNum psw:(NSString *)pswMsg complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock;

/**
 *  检查手机号码是否正确
 *
 *  @param phoneNum      手机号码
 *  @param completeBlock 完成回调
 *  @param errorBlock    错误信息
 */
+ (void)checkTellWithTellNum:(NSString *)phoneNum complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock;

/**
 *  检查两次密码是否相同
 *
 *  @param fistPsw       密码1
 *  @param secondPsw     密码2
 *  @param completeBlock 完成回调
 *  @param errorBlock    错误信息
 */
+ (void)checkPswIsEqualFistPsw:(NSString *)fistPsw secondPsw:(NSString *)secondPsw complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock;

/**
 *  检查姓名是否为空，身份证是否正确
 *
 *  @param name          姓名
 *  @param idCard        身份证号码
 *  @param completeBlock 完成回调
 *  @param errorBlock    返回错误信息
 */
+ (void)checkName:(NSString *)name idCard:(NSString *)idCard complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock;
@end
