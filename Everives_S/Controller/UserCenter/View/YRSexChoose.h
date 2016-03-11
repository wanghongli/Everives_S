//
//  YRSexChoose.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRSexChooseDelegate <NSObject>

-(void)sexChooseTag:(int)sexTag;

@end
#import <UIKit/UIKit.h>

@interface YRSexChoose : UIView

@property (nonatomic, assign) id<YRSexChooseDelegate>delegate;

@end
