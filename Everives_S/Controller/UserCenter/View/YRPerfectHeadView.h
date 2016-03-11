//
//  YRPerfectHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRPerfectHeadViewDelegate <NSObject>

-(void)perfectHeadViewChooseImg;

@end
#import <UIKit/UIKit.h>

@interface YRPerfectHeadView : UIImageView
@property (nonatomic, assign) id<YRPerfectHeadViewDelegate>delegate;
@property (nonatomic, strong) UIImage *userImg;
@end
