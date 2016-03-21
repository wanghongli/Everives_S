//
//  YRExamDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObject.h"

@interface YRExamDownView : UIView
@property (nonatomic, strong) NSString *anayString;
@property (nonatomic, strong) YRQuestionObject *questOb;
+(CGFloat)examDownViewGetHeight:(NSString *)analyseString;
+(CGFloat)examDownViewHeight:(YRQuestionObject *)analyseString;

@end
