//
//  YRExamUserHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/24.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRExamUserHeadViewDelegate <NSObject>

-(void)examUserHeadClick;

@end
#import <UIKit/UIKit.h>

@interface YRExamUserHeadView : UIView

@property (nonatomic, assign) BOOL loginBool;
@property (nonatomic, assign) id<YRExamUserHeadViewDelegate>delegate;
@end
