//
//  YRPublicMethod.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/5.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPublicMethod.h"

@implementation YRPublicMethod
/**
 *  通过整型数据转换为12：30：30  数据
 */
+(NSString *)publicMethodAccodingIntMsgTurnToTimeString:(NSInteger)timeInt
{
    int hour = (int)timeInt/3600;
    NSString *hourString = hour>9 ? [NSString stringWithFormat:@"%d",hour] : [NSString stringWithFormat:@"0%d",hour];
    int minute = timeInt%3600/60;
    NSString *minuteString = minute>9 ? [NSString stringWithFormat:@"%d",minute] : [NSString stringWithFormat:@"0%d",minute];
    int second = timeInt%60%60;
    NSString *secondString = minute>9 ? [NSString stringWithFormat:@"%d",second] : [NSString stringWithFormat:@"0%d",second];
    NSString *textString;
    if (hour<1) {
        if (minute<1) {
            textString = [NSString stringWithFormat:@"%@",secondString];
        }else
            textString = [NSString stringWithFormat:@"%@:%@",minuteString,secondString];
    }else{
        textString = [NSString stringWithFormat:@"%@:%@:%@",hourString,minuteString,secondString];
    }
    return textString;
}
/**
 *  检查是否有网络
 */
+(BOOL)checkNetworkIsAvailable
{
    BOOL network;
    
    return network;
}
/**
 *  修改用户资料
 */
+(void)changeUserMsgWithKeys:(NSArray *)keys values:(NSArray *)values
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary* dicUser = [NSMutableDictionary dictionaryWithDictionary:[userDefault dictionaryForKey:@"user"]];
    for (int i = 0; i<keys.count; i++) {
        [dicUser setObject:values[i] forKey:keys[i]];
    }
    [userDefault setObject:dicUser forKey:@"user"];
    [NSUserDefaults resetStandardUserDefaults];
}
+(NSString *)getOrderStatusWith:(NSInteger)status
{
    NSString *statusString;
    if (status == 0) {
        statusString = @"未支付";
    }else if (status == 1) {
        statusString = @"已支付,等待同伴一起拼";
    }else if (status == 2) {
        statusString = @"已支付,等待去练车";
    }else if (status == 3) {
        statusString = @"已完成,等待评价";
    }else if (status == 4) {
        statusString = @"已评价";
    }else if (status == 5) {
        statusString = @"已取消";
    }
    return statusString;
}
+ (NSString *)getDateAndWeekWith:(NSString *)dateString
{
    NSString *timeString;
    NSString *datey = [dateString substringToIndex:4];
    NSString *datem = [dateString substringWithRange:NSMakeRange(5, 2)];
    NSString *dated = [dateString substringFromIndex:8];
    NSString *calendarString = [NSString stringWithFormat:@"%@年%@月%@日",datey,datem,dated];
    NSString *weekString = [NSString getTheDayInWeek:dateString];
    timeString = [NSString stringWithFormat:@"%@ %@",calendarString,weekString];
    return timeString;
}

+ (NSString *)getDetailLearnTimeWith:(NSInteger)time
{
    NSArray *times = @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"];
    NSString *string = @"";
    NSString *timeString = [NSString stringWithFormat:@"%ld",time];
    for (int i = 0; i<timeString.length; i++) {
        NSString *stringTime = [timeString substringWithRange:NSMakeRange(i, 1)];
        NSString *realTime = times[[stringTime integerValue]];
        if (string.length) {
            string = [string stringByAppendingString:@"&"];
            string = [string stringByAppendingString:realTime];
        }else{
            string = [NSString stringWithString:realTime];
        }
    }
    return string;
}
@end
