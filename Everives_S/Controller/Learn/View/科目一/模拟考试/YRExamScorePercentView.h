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
@property (nonatomic, strong) NSString *headString;

+ (CGFloat)getExamScorePercentViewHeight:(NSString *)scoreString withHeadString:(NSString *)headString;

@end
