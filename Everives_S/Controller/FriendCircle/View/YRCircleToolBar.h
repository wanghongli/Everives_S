//
//  YRCircleToolBar.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRCircleToolBarDelegate <NSObject>

-(void)commentOrAttentTouch:(NSInteger)commentOrAttent;//1表示点赞2表示消息

@end
#import <UIKit/UIKit.h>
@class YRWeibo;

@interface YRCircleToolBar : UIImageView
@property (nonatomic, strong) YRWeibo *status;

@end
