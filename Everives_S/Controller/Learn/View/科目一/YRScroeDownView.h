//
//  YRScroeDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/5/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRScroeDownViewDelegate <NSObject>

-(void)scroeDownViewClick:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRScroeDownView : UIView
@property (nonatomic, assign) id<YRScroeDownViewDelegate>delegate;
@end
