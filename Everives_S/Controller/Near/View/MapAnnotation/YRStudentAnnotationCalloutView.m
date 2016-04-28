//
// YRStudentAnnotationCalloutView.m
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "YRStudentAnnotationCalloutView.h"
#import "DistanceToolFuc.h"
#import "YRSchoolModel.h"
#import "YRPictureModel.h"
#import "NSString+Tools.h"
#define kArrorHeight        10

@interface YRStudentAnnotationCalloutView ()
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *address;
@property(nonatomic,strong) UILabel *distance;
@property(nonatomic,strong) UILabel *introLabel;

@end
@implementation YRStudentAnnotationCalloutView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)buildUI{
    [self addSubview:self.imageView];
    [self addSubview:self.name];
    [self addSubview:self.introLabel];
//    [self addSubview:self.address];
//    [self addSubview:self.distance];
}
//绘制calloutView的背景
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

#pragma mark  - Getters
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 90, 90)];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageurl] placeholderImage:[UIImage imageNamed:kUSERAVATAR_PLACEHOLDR]];
    }
    return _imageView;
}
-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(98, 24, 110, 20)];
        _name.font = kFontOfLetterBig;
        _name.text = _namestr;
    }
    return _name;
}


-(UILabel *)introLabel{
    if (!_introLabel) {
        _introLabel = [[UILabel alloc] init];
        UIFont *font = kFontOfLetterMedium;
        CGSize size = [_intro sizeWithFont:font maxSize:CGSizeMake(216 - 112, 100)];
        _introLabel.font = font;
        _introLabel.text = _intro;
        _introLabel.numberOfLines = 0;
        _introLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _introLabel.frame = CGRectMake(98, 50, size.width, 40);
        _introLabel.textColor = kTextlightGrayColor;
    }
    return _introLabel;
}
/*
-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] initWithFrame:CGRectMake(98, 58, 100, 20)];
        _address.font = [UIFont systemFontOfSize:13];
        _address.text = _addrstr;
    }
    return _address;
}
-(UILabel *)distance{
    if (!_distance) {
        _distance = [[UILabel alloc] initWithFrame:CGRectMake(98, 4, 100, 20)];
        _distance.font = [UIFont systemFontOfSize:15];
        _distance.text = _distancestr;
    }
    return _distance;
}*/
@end
