//
//  YRCircleBtn.m
//  DrawCircle
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 Yeming. All rights reserved.
//

#import "YRCircleBtn.h"
#define kWight 2
@interface  YRCircleBtn ()
{
    CAShapeLayer *arcLayer;
}
@end
@implementation YRCircleBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.imageView.center = CGPointMake(self.frame.size.width/2,self.frame.size.width/2);
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = self.frame.size.width/2;
        self.imageView.layer.borderWidth = kWight;
        self.imageView.layer.borderColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:222/255.0 alpha:1].CGColor;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height*0.87, contentRect.size.width, contentRect.size.height*0.13);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}
-(void)initCircleRangeFloat:(CGFloat)rangeFloat
{
    
    if (arcLayer) {
        [arcLayer removeFromSuperlayer];
    }
    UIBezierPath *path=[UIBezierPath bezierPath];
    
    CGRect rect=self.frame;
    
    [path addArcWithCenter:CGPointMake(rect.size.width/2,rect.size.width/2) radius:rect.size.width/2-kWight/2 startAngle:3*M_PI/2 endAngle:[self calculationTheCircleRange:rangeFloat] clockwise:NO];
    arcLayer=[CAShapeLayer layer];
    arcLayer.path=path.CGPath;//46,169,230
    arcLayer.fillColor=[UIColor clearColor].CGColor;
    arcLayer.strokeColor=[UIColor colorWithRed:52/255.0 green:53/255.0 blue:54/255.0 alpha:1].CGColor;
    arcLayer.lineWidth=self.lineW ? self.lineW:kWight;
    arcLayer.frame=CGRectMake(0, 0, rect.size.width, rect.size.height);
    [self.layer addSublayer:arcLayer];
    [self drawLineAnimation:arcLayer];
    
}
-(CGFloat)calculationTheCircleRange:(CGFloat)rangeFloat
{
    CGFloat circleRange = 3*M_PI/2;
    if (rangeFloat>=0&&rangeFloat<0.75) {
        circleRange-=rangeFloat*2*M_PI;
    }else if (rangeFloat>=0.75&&rangeFloat<1.0){
        circleRange = 7*M_PI/2-rangeFloat*2*M_PI;
    }else{
        circleRange = 3.001*M_PI/2;
    }
    return circleRange;
}
-(void)drawLineAnimation:(CALayer*)layer
{
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1;
    bas.delegate=self;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"key"];
}
@end
