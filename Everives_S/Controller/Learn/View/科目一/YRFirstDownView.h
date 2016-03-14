//
//  YRFirstDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRFirstDownViewDelegate <NSObject>

-(void)firstDownBtnClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRFirstDownView : UIView
@property (nonatomic, assign) id<YRFirstDownViewDelegate>delegate;
@end
