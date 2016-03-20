//
//  KGFishingPointCalloutView.m
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "YRAnnotationCalloutView.h"
#import "DistanceToolFuc.h"
#import "YRMapAnnotaionModel.h"
#define kPortraitMargin     7
#define kLineMargin         5
#define kPortraitWidth      70
#define kPortraitHeight     50

#define kStarWidth          15
#define kTitleWidth         100
#define kTitleHeight        10
#define kArrorHeight        10

@interface YRAnnotationCalloutView ()

@property(nonatomic,strong) UIImageView *fishingPointImageView;
@property(nonatomic,strong) UILabel *fishingPointNameLabel;
@property(nonatomic,strong) UILabel *fishingPointScoreLabel;
@property(nonatomic,strong) UILabel *fishingPointDistanceAndCostLabel;


@end

@implementation YRAnnotationCalloutView

- (id)initWithFrame:(CGRect)frame model:(YRMapAnnotaionModel*)model
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.model =model;
        [self initSubViews];
    }
    return self;
}

//calloutView的布局
- (void)initSubViews
{
    /*
    // 添加图片
    self.fishingPointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, kPortraitWidth, kPortraitHeight)];
    [self.fishingPointImageView sd_setImageWithURL:[NSURL URLWithString:self.model.preview]];
    [self addSubview:self.fishingPointImageView];
    // 添加名称
    self.fishingPointNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin+2, kTitleWidth, kTitleHeight)];
    self.fishingPointNameLabel.text = self.model.name;
    self.fishingPointNameLabel.font = [UIFont boldSystemFontOfSize:10];
    self.fishingPointNameLabel.textColor = [UIColor blackColor];
    [self addSubview:self.fishingPointNameLabel];
    
    // 添加分数和星星
    self.fishingPointScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth+5*kStarWidth+kPortraitMargin, kPortraitMargin+kLineMargin+kTitleHeight, kStarWidth*2, kStarWidth)];
    self.fishingPointScoreLabel.font = [UIFont systemFontOfSize:13];
    self.fishingPointScoreLabel.textColor = [UIColor blackColor];
    self.fishingPointScoreLabel.text = [NSString stringWithFormat:@"%@.0",self.model.score];
    [self addSubview:self.fishingPointScoreLabel];
    
    // 添加钓点星级
    for(int i = 0;i<5;i++){
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth+kStarWidth*i, kPortraitMargin+kLineMargin+kTitleHeight, kStarWidth, kStarWidth)];
        if(i<[self.model.score intValue] ){
            star.image = [UIImage imageNamed:@"ic_score_focus"];
        }else{
            star.image = [UIImage imageNamed:@"ic_score_unfocus"];
        }
        [self addSubview:star];
    }
    
    // 添加地理位置
    self.fishingPointDistanceAndCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin * 2 + kPortraitWidth, kPortraitMargin + kTitleHeight+kLineMargin*2+kStarWidth, kTitleWidth, kTitleHeight)];
    self.fishingPointDistanceAndCostLabel.font = [UIFont systemFontOfSize:10];
    self.fishingPointDistanceAndCostLabel.textColor = [UIColor blackColor];
    double lat1 = [KUserLocation.latitude doubleValue];
    double lng1 = [KUserLocation.longitude doubleValue];
    double lat2 = [self.model.lat doubleValue];
    double lng2 = [self.model.lng doubleValue];
    double distance = [ToolFuc calculateDistanceWithLongitude1:lng1 Laititude1:lat1 Longitude2:lng2 Laititude2:lat2]/1000;
    self.fishingPointDistanceAndCostLabel.text = [NSString stringWithFormat:@"%.2fkm,%@￥",distance,self.model.cost];
    [self addSubview:self.fishingPointDistanceAndCostLabel];
    
     //添加简介
    */
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

@end
