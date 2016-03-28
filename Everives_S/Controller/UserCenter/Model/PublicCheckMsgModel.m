//
//  PublicCheckMsgModel.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "PublicCheckMsgModel.h"
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
+ (void)checkName:(NSString *)name idCard:(NSString *)idCard complete:(void (^)(BOOL))completeBlock error:(void (^)(NSString *))errorBlock
{
    NSString *backMsg;
    if (![name isValid]) {
        backMsg = @"姓名不能为空";
        if (errorBlock) {
            errorBlock(backMsg);
            return;
        }
    }
    
    if (![idCard isValid]) {
        backMsg = @"身份证号码不能为空";
        if (errorBlock) {
            errorBlock(backMsg);
            return;
        }
    }
    
    BOOL flag;
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:idCard];
    if (!flag) {
        backMsg = @"身份证号码有误，请重新输入!!";
        if (errorBlock) {
            errorBlock(backMsg);
            return;
        }
    }
    
    if (completeBlock) {
        completeBlock(YES);
    }
}



//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
@end
