//
//  YRFirstHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRFirstHeadViewDelegate <NSObject>

-(void)firstHeadViewBtnClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRFirstHeadView : UIView

@property (nonatomic, assign) id<YRFirstHeadViewDelegate>delegate;

@end
