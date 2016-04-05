//
//  YRLearnPracticeController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRLearnPracticeController : UIViewController
/**
 *  顺序练习中的继续之前开做题的id
 */
@property (nonatomic, assign) NSInteger currentID;
/**
 *  0表示：模拟考试；1表示顺序练习；2表示随机练习；3表示专项练习；4表示错题；5表示收藏
 */
@property (nonatomic, assign) NSInteger menuTag;
/**
 *  专题库的分类id
 */
@property (nonatomic, assign) NSInteger perfisonalKind;
/**
 *  yes科目四 no科目一
 */
@property (nonatomic, assign) BOOL objectFour;
@end
