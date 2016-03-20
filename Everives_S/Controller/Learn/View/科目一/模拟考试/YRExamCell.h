//
//  YRExamCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObject.h"
@interface YRExamCell : UITableViewCell
@property (nonatomic, strong) YRQuestionObject *quest;
@property (nonatomic, strong) NSString *msgString;
@property (nonatomic, assign) NSInteger menuString;
@end
