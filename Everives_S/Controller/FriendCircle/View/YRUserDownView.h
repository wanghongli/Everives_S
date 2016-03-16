//
//  YRUserDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRUserDownViewDelegate <NSObject>

-(void)userDownViewBtnTag:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRUserDownView : UIView
@property (nonatomic, assign) id<YRUserDownViewDelegate>delegate;
@end
