//
//  PublicCheckMsgModel.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "PublicCheckMsgModel.h"
#import "NSString+Tools.h"
@implementation PublicCheckMsgModel

+ (void)loginMsgCheckTell:(NSString *)phoneNum psw:(NSString *)pswMsg complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock
{
    if (![phoneNum isValid]) {
        if (errorBlock) {
            errorBlock(@"手机号码不能为空");
            return;
        }
    }
    
    if (![pswMsg isValid]) {
        if (errorBlock) {
            errorBlock(@"密码不能为空");
            return;
        }
    }
    
    if (completeBlock) {
        if (completeBlock) {
            completeBlock(YES);
        }
    }
    
}

+ (void)checkTellWithTellNum:(NSString *)phoneNum complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock
{
    if (![phoneNum isValid]) {
        if (errorBlock) {
            errorBlock(@"手机号码不能为空");
            return;
        }
    }
    
    if (completeBlock) {
        if (completeBlock) {
            completeBlock(YES);
        }
    }
}

+ (void)checkPswIsEqualFistPsw:(NSString *)fistPsw secondPsw:(NSString *)secondPsw complete:(void (^)(BOOL isSuccess))completeBlock error:(void (^)(NSString *errorMsg))errorBlock
{
    NSString *backMsg;
    if (![fistPsw isValid] ||![secondPsw isValid]) {
        backMsg = @"密码不能为空";
        if (errorBlock) {
            errorBlock(backMsg);
            return;
        }
    }
    
    if (![fistPsw isEqualToString:secondPsw]) {
        backMsg = @"两次密码不相同";
        if (errorBlock) {
            errorBlock(backMsg);
            return;
        }
    }
    
    
    
    if (completeBlock) {
        completeBlock(YES);
    }
    
}

@end
