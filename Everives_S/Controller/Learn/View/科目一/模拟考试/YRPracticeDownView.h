//
//  YRPracticeDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRPracticeDownViewDelegate <NSObject>

- (void)praciceDownViewBtnClick:(NSInteger)btnTag with:(NSString *)quesID;

@end
#import <UIKit/UIKit.h>
#import "YRQuestionObj.h"
@interface YRPracticeDownView : UIView

@property (nonatomic, assign) id<YRPracticeDownViewDelegate>delegate;

@property (nonatomic, strong) NSString *numbString;

@property (nonatomic, strong) YRQuestionObj *questObj;
@end
