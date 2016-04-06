//
//  YRChooseMenuView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/5.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRChooseMenuView : UIImageView
@property (nonatomic, strong) NSString *menuString;
/**
 *  yes显示成功 no显示错误照片
 */
@property (nonatomic, assign) BOOL showImgBool;

/**
 *  0表示默认状态（单选或者判断题）  1表示选中状态（多项选择）  2表示多项选择没有选的正确答案状态（多项选择题）
 */
@property (nonatomic, assign) NSInteger selectState;

@end
