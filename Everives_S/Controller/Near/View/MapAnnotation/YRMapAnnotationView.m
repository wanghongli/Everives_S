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
@property(nonatomic,assign) NSInteger kind;
@property(nonatomic,strong) NSString *modelID;
@end

@implementation YRMapAnnotationView

#define kCalloutWidth       216.0
#define kCalloutHeight      110.0

#pragma mark - Handle Action

- (void)btnAction
{
    [self.delegate callOutViewClickedKind:_kind modelID:_modelID];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        [self addSubview:self.calloutView];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, 0, kCalloutWidth, kCalloutHeight);
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.calloutView addSubview:btn];
        
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

//不重写这个方法点击事件不会生效
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
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
        _kind = 1;
        _modelID = ((YRSchoolModel*)(self.annotation)).id;
    }else if ([self.annotation isKindOfClass:[YRCoachModel class]]){
        ((YRCoachAnnotationCalloutView*)_calloutView).imageurl = ((YRCoachModel*)(self.annotation)).avatar;
        ((YRCoachAnnotationCalloutView*)_calloutView).namestr = ((YRCoachModel*)(self.annotation)).name;
        ((YRCoachAnnotationCalloutView*)_calloutView).scorestr = ((YRCoachModel*)(self.annotation)).grade;
        [((YRCoachAnnotationCalloutView*)_calloutView) buildUI];
        _kind = 2;
        _modelID = ((YRCoachModel*)(self.annotation)).id;
    }else if ([self.annotation isKindOfClass:[YRUserStatus class]]){
        ((YRStudentAnnotationCalloutView*)_calloutView).imageurl = ((YRUserStatus*)(self.annotation)).avatar;
        ((YRStudentAnnotationCalloutView*)_calloutView).namestr = ((YRUserStatus*)(self.annotation)).name;
        ((YRStudentAnnotationCalloutView*)_calloutView).intro = ((YRUserStatus*)(self.annotation)).sign;
        [((YRStudentAnnotationCalloutView*)_calloutView) buildUI];
        _kind = 3;
        _modelID = ((YRUserStatus*)(self.annotation)).id;
    }
    
    
    return _calloutView;
}

@end
