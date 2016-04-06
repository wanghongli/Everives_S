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
@end
