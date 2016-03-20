//
//  YRLearnCollectionCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRQuestionObject.h"
@interface YRLearnCollectionCell : UICollectionViewCell
@property (nonatomic, strong) YRQuestionObject *questionOb;
@property (nonatomic, strong) void (^answerIsClickBlock)(YRQuestionObject *answerQues);

@end
