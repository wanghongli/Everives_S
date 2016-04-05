//
//  YRExamDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObj.h"

@interface YRExamDownView : UIView
@property (nonatomic, strong) NSString *anayString;
@property (nonatomic, strong) YRQuestionObj *questOb;
+(CGFloat)examDownViewGetHeight:(NSString *)analyseString;
+(CGFloat)examDownViewHeight:(YRQuestionObj *)analyseString;

@end
