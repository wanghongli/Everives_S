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
#import "YRUserStatus.h"
#import "YRCoachModel.h"
#import "YRSchoolAnnotationCalloutView.h"
#import "YRCoachAnnotationCalloutView.h"
#import "YRStudentAnnotationCalloutView.h"
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

-(UIView *)calloutView{
    if (!_calloutView)
    {
        if ([self.annotation isKindOfClass:[YRSchoolModel class]]) {
            _calloutView = [[YRSchoolAnnotationCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)] ;
        }else if([self.annotation isKindOfClass:[YRCoachModel class]]){
            _calloutView = [[YRCoachAnnotationCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)] ;
        }else if([self.annotation isKindOfClass:[YRUserStatus class]]){
            _calloutView = [[YRStudentAnnotationCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)] ;
        
        }
        _calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
    }
    if ([self.annotation isKindOfClass:[YRSchoolModel class]]) {
        ((YRSchoolAnnotationCalloutView*)_calloutView).imageurl = ((YRSchoolModel*)(self.annotation)).imaageurl;
        ((YRSchoolAnnotationCalloutView*)_calloutView).namestr = ((YRSchoolModel*)(self.annotation)).name;
        ((YRSchoolAnnotationCalloutView*)_calloutView).scorestr = ((YRSchoolModel*)(self.annotation)).grade;
        ((YRSchoolAnnotationCalloutView*)_calloutView).addrstr = ((YRSchoolModel*)(self.annotation)).address;
        ((YRSchoolAnnotationCalloutView*)_calloutView).distancestr = ((YRSchoolModel*)(self.annotation)).distance;
        [((YRSchoolAnnotationCalloutView*)_calloutView) buildUI];
    }else if ([self.annotation isKindOfClass:[YRCoachModel class]]){
        ((YRCoachAnnotationCalloutView*)_calloutView).imageurl = ((YRCoachModel*)(self.annotation)).avatar;
        ((YRCoachAnnotationCalloutView*)_calloutView).namestr = ((YRCoachModel*)(self.annotation)).name;
        ((YRCoachAnnotationCalloutView*)_calloutView).scorestr = ((YRCoachModel*)(self.annotation)).grade;
        [((YRCoachAnnotationCalloutView*)_calloutView) buildUI];
    }else if ([self.annotation isKindOfClass:[YRUserStatus class]]){
        ((YRStudentAnnotationCalloutView*)_calloutView).imageurl = ((YRUserStatus*)(self.annotation)).avatar;
        ((YRStudentAnnotationCalloutView*)_calloutView).namestr = ((YRUserStatus*)(self.annotation)).name;
        ((YRStudentAnnotationCalloutView*)_calloutView).intro = ((YRUserStatus*)(self.annotation)).sign;
        [((YRStudentAnnotationCalloutView*)_calloutView) buildUI];
    }
    
    
    return _calloutView;
}

@end
