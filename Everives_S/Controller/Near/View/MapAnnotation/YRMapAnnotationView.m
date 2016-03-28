//
//  KGFishingPointAnnotationView.m
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import "YRMapAnnotationView.h"
#import <UIImageView+WebCache.h>
#import "YRSchoolModel.h"
#import "YRPictureModel.h"
@interface YRMapAnnotationView ()

@end

@implementation YRMapAnnotationView

#define kCalloutWidth       210.0
#define kCalloutHeight      98.0

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
    if (!_calloutView)
    {
        _calloutView = [[YRAnnotationCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)] ;
        _calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
    }
    _calloutView.imageurl = ((YRSchoolModel*)(self.annotation)).imaageurl;
    _calloutView.namestr = ((YRSchoolModel*)(self.annotation)).name;
    _calloutView.scorestr = ((YRSchoolModel*)(self.annotation)).grade;
    _calloutView.addrstr = ((YRSchoolModel*)(self.annotation)).address;
    _calloutView.distancestr = ((YRSchoolModel*)(self.annotation)).distance;
    [_calloutView buildUI];
    return _calloutView;
}

@end
