//
//  ToolFuc.m
//  SkyFish
//
//  Created by darkclouds on 15/12/12.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import "DistanceToolFuc.h"

@implementation DistanceToolFuc
#pragma mark - 工具函数  利用经纬度计算两点之间的距离
+(double)calculateDistanceWithLongitude1:(double)lng1 Laititude1: (double)lat1 Longitude2: (double)lng2 Laititude2:(double)lat2{
    double a, b, R;
    R = 6378137; // 地球半径
    lat1 = lat1 * M_PI / 180.0;
    lat2 = lat2 * M_PI / 180.0;
    a = lat1 - lat2;
    b = (lng1 - lng1) * M_PI / 180.0;
    double d;
    double sa2, sb2;
    sa2 = sin(a / 2.0);
    sb2 = sin(b / 2.0);
    d = 2* R * asin(sqrt(sa2 * sa2 + cos(lat1) * cos(lat2) * sb2 * sb2));
    return d;
}
@end
