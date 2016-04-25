//
//  UIColor+Tool.m
//  Everives_S
//
//  Created by darkclouds on 16/4/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "UIColor+Tool.h"

@implementation UIColor (Tool)
+ (UIColor *)colorWithRGB:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}



@end
