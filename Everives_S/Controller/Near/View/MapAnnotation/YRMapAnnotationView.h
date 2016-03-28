//
//  KGFishingPointAnnotationView.h
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMap3DMap/MAMapKit/MAAnnotationView.h>
@interface YRMapAnnotationView : MAAnnotationView
@property (nonatomic, strong) UIView *calloutView;
@end