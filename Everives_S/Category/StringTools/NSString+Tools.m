//
//  NSString+Validation.m
//  TouWroldApp
//
//  Created by 李大鹏 on 15/6/17.
//  Copyright (c) 2015年 com.touworld.ios. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

//Checking if String is empty or nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]||[self isKindOfClass:[NSNull class]])  ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (NSString *)moneyString
{
    if (self.length < 3)
    {
        return self;
    }
    NSString *numStr = self;
    NSArray *array = [numStr componentsSeparatedByString:@"."];
    NSString *numInt = [array objectAtIndex:0];
    if (numInt.length <= 3)
    {
        return self;
    }
    NSString *suffixStr = @"";
    if ([array count] > 1)
    {
        suffixStr = [NSString stringWithFormat:@".%@",[array objectAtIndex:1]];
    }
    
    NSMutableArray *numArr = [[NSMutableArray alloc] init];
    while (numInt.length > 3)
    {
        NSString *temp = [numInt substringFromIndex:numInt.length - 3];
        numInt = [numInt substringToIndex:numInt.length - 3];
        [numArr addObject:[NSString stringWithFormat:@",%@",temp]];//得到的倒序的数据
    }
    NSInteger count = [numArr count];
    for (NSInteger i = 0; i < count; i++)
    {
        numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
    }
    numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
    return [numStr copy];
}

- (NSString *)removeMoneyFormat
{
    if (self.length < 3)
    {
        return self;
    }
    
    NSString *trimmedString = [self stringByReplacingOccurrencesOfString:@"," withString:@""];

    return trimmedString;
}

// Add substring to main String
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

- (BOOL)isVAlidPhoneNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,181,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,181,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[1278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,177
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isVAlidPosetCode
{
    NSString * postcode = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *regextestpostcode = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", postcode];
    
    if ([regextestpostcode evaluateWithObject:self] == YES)
    {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString*)intervalSinceNow:(NSString*) theDate
{
    NSDateFormatter*date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[NSDate dateWithTimeIntervalSince1970:[theDate floatValue]];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha= now-late;
    
    //发表在一小时之内
    if(cha/3600<1) {
        if(cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    
    //在一小时以上24小以内
    else if(cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    //发表在24以上10天以内
    else if(cha/86400>1&&cha/(86400*3)<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    
    //发表时间大于3天
    else
    {
        /*
         NSArray*array = [theDate componentsSeparatedByString:@" "];
         timeString = [array objectAtIndex:0];
         timeString = [timeString substringWithRange:NSMakeRange(5, [timeString length]-5)];
         */
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"MM-dd HH:mm"];
        timeString = [formatter stringFromDate:d];
    }
    return timeString;
}

+ (NSString *)dateStringWithInterval:(NSString *)interval
{
    double lastactivityInterval = [interval doubleValue];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;

}

+ (NSString *)dateStringWithAllInterval:(NSString *)interval
{
    double lastactivityInterval = [interval doubleValue];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:ss"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:lastactivityInterval];
    
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
    
}

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
