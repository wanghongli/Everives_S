//
//  YRFirstMiddleView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRFirstMiddleViewDelegate <NSObject>

-(void)firstMiddleViewBtnClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRFirstMiddleView : UIView
@property (nonatomic, assign) id<YRFirstMiddleViewDelegate>delegate;
@end
