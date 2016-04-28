//
//  YRTeacherDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRTeacherDownViewDelegate <NSObject>

-(void)teacherDownViewBtnClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRTeacherDownView : UIView
@property (nonatomic, assign) id<YRTeacherDownViewDelegate>delegate;
@property (nonatomic, assign) BOOL attentionBool;
@end
