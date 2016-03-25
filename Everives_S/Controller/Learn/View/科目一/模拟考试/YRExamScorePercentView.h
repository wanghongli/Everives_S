//
//  YRExamScorePercentView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRExamScorePercentView : UIView

@property (nonatomic, strong) NSString *scoreString;


+ (CGFloat)getExamScorePercentViewHeight:(NSString *)scoreString;

@end
