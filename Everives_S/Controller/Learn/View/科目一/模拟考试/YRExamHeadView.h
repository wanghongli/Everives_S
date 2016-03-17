//
//  YRExamHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObject.h"
@interface YRExamHeadView : UIView
@property (nonatomic, strong) YRQuestionObject *ques;
+ (CGFloat)examHeadViewHeight:(YRQuestionObject *)ques;
@end
