//
//  YRPracticeDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRPracticeDownViewDelegate <NSObject>

- (void)praciceDownViewBtnClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRPracticeDownView : UIView

@property (nonatomic, assign) id<YRPracticeDownViewDelegate>delegate;

@property (nonatomic, strong) NSString *numbString;

@end
