//
//  YRLineView.m
//  Everives_S
//
//  Created by darkclouds on 16/4/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLineView.h"

@implementation YRLineView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.294 alpha:1.000].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 0.5f);
    
    CGContextMoveToPoint(context, 0.0f, 0.0f); //start at this point
    
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}
@end
