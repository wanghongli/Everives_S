//
//  YRLearnPracticeController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRLearnPracticeController : UIViewController
@property (nonatomic, assign) NSInteger currentID;//顺序练习中的
/**
 *  0表示：模拟考试；1表示顺序练习；2表示随机练习；3表示专项练习；
 */
@property (nonatomic, assign) NSInteger menuTag;
@end
