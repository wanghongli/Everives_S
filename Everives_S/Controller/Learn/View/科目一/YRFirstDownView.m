//
//  YRFirstDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFirstDownView.h"
#import "YRUpImgBtn.h"

#define kDistance 5
@interface YRFirstDownView ()
{
    NSArray *array;
}
@end
@implementation YRFirstDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        array = @[@"我的错题",@"我的收藏",@"练习统计",@"我的成绩"];
        self.backgroundColor = [UIColor whiteColor];
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    for (int i = 0; i<4; i++) {
        CGFloat distance = kSizeOfScreen.width*0.35/5;
        CGFloat w = kSizeOfScreen.width*(1-0.35)/4;
        CGFloat x = distance + i*(distance+w);
        CGFloat y = kDistance;
        CGFloat h = self.frame.size.height-2*kDistance;
        YRUpImgBtn *upimgBtn = [[YRUpImgBtn alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [upimgBtn setTitle:array[i] forState:UIControlStateNormal];
        [upimgBtn setImage:[UIImage imageNamed:@"timeline_image_placeholder"] forState:UIControlStateNormal];
        [upimgBtn setTitleColor:[UIColor colorWithRed:145/255.0 green:146/255.0 blue:147/255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:upimgBtn];
        
    }
}

@end
