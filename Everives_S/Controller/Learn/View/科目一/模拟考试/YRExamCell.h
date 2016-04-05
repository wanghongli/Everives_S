//
//  YRExamCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObj.h"
@interface YRExamCell : UITableViewCell
@property (nonatomic, strong) YRQuestionObj *quest;
@property (nonatomic, strong) NSString *msgString;
@property (nonatomic, assign) NSInteger menuString;
//1考试状态  0练习状态
@property (nonatomic, assign) BOOL examBool;
@end
