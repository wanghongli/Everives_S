//
//  YRLearnCollectionCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObj.h"
@interface YRLearnCollectionCell : UICollectionViewCell
@property (nonatomic, strong) YRQuestionObj *questionOb;
@property (nonatomic, strong) void (^anserErrorClickBlock)();
@property (nonatomic, strong) void (^answerIsClickBlock)(YRQuestionObj *answerQues);

@property (nonatomic, assign) NSInteger MNCurrentID;

//显示答案
@property (nonatomic, assign) BOOL showAanly;
//考试状态
@property (nonatomic, assign) BOOL examBool;
@end
