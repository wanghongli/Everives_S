//
//  KGFishingPointCalloutView.h
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRMapAnnotaionModel;
@interface YRAnnotationCalloutView : UIView
@property(nonatomic,strong) YRMapAnnotaionModel * model;
- (id)initWithFrame:(CGRect)frame model:(YRMapAnnotaionModel*)model;
@end
