//
//  YRMenuHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRMenuHeadViewDelegate <NSObject>

-(void)menuHeadViewLoginClick;
-(void)menuHeadViewNotiClick;

@end
#import <UIKit/UIKit.h>

@interface YRMenuHeadView : UIImageView
@property (nonatomic, assign) id<YRMenuHeadViewDelegate>delegate;
@property (nonatomic, assign) BOOL loginBool;

@end
