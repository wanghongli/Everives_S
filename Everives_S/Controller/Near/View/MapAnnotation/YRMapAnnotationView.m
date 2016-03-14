//
//  KGFishingPointAnnotationView.m
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import "YRMapAnnotationView.h"
#import "YRMapAnnotaionModel.h"
@interface YRMapAnnotationView ()

@end

@implementation YRMapAnnotationView

#define kCalloutWidth       200.0
#define kCalloutHeight      75.0

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

-(YRAnnotationCalloutView *)calloutView{
    if (_calloutView == nil)
    {
        self.calloutView = [[YRAnnotationCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight) model:(YRMapAnnotaionModel*)(self.annotation)] ;
        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
    }
    return _calloutView;
}

@end
