//
//  YRTeacherStarLevelView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRTeacherStarLevelViewDelegate <NSObject>

- (void)teacherStarLevelMenu:(NSString *)menu starLevel:(NSInteger)starLevel;

@end
#import <UIKit/UIKit.h>

@interface YRTeacherStarLevelView : UIView

@property (nonatomic, assign) id<YRTeacherStarLevelViewDelegate>delegate;

@end
