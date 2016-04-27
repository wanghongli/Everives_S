//
//  YRSlider.m
//  Everives_S
//
//  Created by darkclouds on 16/4/27.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSlider.h"

@implementation YRSlider
-(CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], -30 , -30);
}
-(CGRect)trackRectForBounds:(CGRect)bounds{
    return CGRectInset([super trackRectForBounds:bounds], 0, -1);
}
@end