//
//  YRCirclePhoto.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRWeibo.h"
@interface YRCirclePhoto : UIImageView

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) YRWeibo *circleModel;

@end
