//
//  YRStarLevelDetailView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//



#import <UIKit/UIKit.h>
@class YRStarLevelDetailView;
@protocol YRStarLevelDetailViewDelegate <NSObject>

-(void)starLevelDetailViewWhichStarClick:(NSInteger)starTag with:(YRStarLevelDetailView*)starView;

@end
@interface YRStarLevelDetailView : UIView

@property (nonatomic, assign) id<YRStarLevelDetailViewDelegate>delegate;
@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) NSInteger starNum;

@end
