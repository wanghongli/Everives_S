//
//  ToolFuc.m
//  SkyFish
//
//  Created by darkclouds on 15/12/12.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import "DistanceToolFuc.h"

@implementation DistanceToolFuc
#pragma mark - 工具函数  利用经纬度计算两点之间的距离  返回单位 m
+(double)calculateDistanceWithLongitude1:(double)lng1 Laititude1: (double)lat1 Longitude2: (double)lng2 Laititude2:(double)lat2{
//    NSLog(@"calculateDistanceWithLongitude1   %f  %f         %f  %f",lat1,lng1,lat2,lng2);
    CLLocation *point1 = [[CLLocation alloc] initWithLatitude:lat1 longitude:lng1];
    CLLocation *point2 = [[CLLocation alloc] initWithLatitude:lat2 longitude:lng2];
    double dis = [point1 distanceFromLocation:point2];
    return dis;
}
@end
