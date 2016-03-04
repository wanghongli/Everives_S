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


@end
