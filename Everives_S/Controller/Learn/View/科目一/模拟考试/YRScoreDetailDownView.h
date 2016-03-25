//
//  YRScoreDetailDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRScoreDetailDownViewDelegate <NSObject>

- (void)scoreDetailDownViewBtnClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRScoreDetailDownView : UIView
@property (nonatomic, assign) id<YRScoreDetailDownViewDelegate>delegate;
@end
