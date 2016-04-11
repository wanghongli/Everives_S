//
//  KGFishingPointAnnotationView.h
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMap3DMap/MAMapKit/MAAnnotationView.h>

@protocol CallOutViewDelegate <NSObject>
-(void)callOutViewClickedKind:(NSInteger)kind modelID:(NSString*) modelID;
@end
@interface YRMapAnnotationView : MAAnnotationView
@property (nonatomic, strong) UIView *calloutView;
@property(nonatomic,weak) id<CallOutViewDelegate> delegate;
@end