//
//  YRGotScoreController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//  得分

#import <UIKit/UIKit.h>

@interface YRGotScoreController : UIViewController

@property (nonatomic, assign) NSInteger scroe;
/**
 *  yes科目四 no科目一
 */
@property (nonatomic, assign) BOOL objFour;
/**
 *  花费时间
 */
@property (nonatomic, assign) NSInteger costTime;
/**
 *  剩余时间
 */
@property (nonatomic, assign) NSInteger surplusTime;
@end
