//
//  YRFirstHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFirstHeadView.h"
#import "YRCircleBtn.h"

@interface YRFirstHeadView ()
{
    NSArray *array;
    NSArray *percentArray;
}
@end
@implementation YRFirstHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        array = @[@"顺序练习",@"随机练习",@"专题练习"];
        percentArray = @[@"0.75",@"0.3",@"0"];
        self.backgroundColor = [UIColor whiteColor];
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    for (int i = 0; i<3; i++) {
        CGFloat xDistance = (kSizeOfScreen.width*0.25-20)/4;
        CGFloat w = kSizeOfScreen.width*0.25;
        CGFloat x = 10+xDistance+i*xDistance+i*w;
        CGFloat y = 15;
        CGFloat h = w/0.78;
        YRCircleBtn *circleBtn = [[YRCircleBtn alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [circleBtn setTitle:array[i] forState:UIControlStateNormal];
        NSString *imgName = [NSString stringWithFormat:@"p%d",i+1];
        [circleBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [circleBtn setTitleColor:[UIColor colorWithRed:145/255.0 green:146/255.0 blue:147/255.0 alpha:1] forState:UIControlStateNormal];
        [circleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        circleBtn.tag = i;
        [circleBtn initCircleRangeFloat:[percentArray[i] floatValue]];
        [self addSubview:circleBtn];
        
    }
}

-(void)btnClick:(YRCircleBtn*)sender
{
    [self.delegate firstHeadViewBtnClick:sender.tag];
}

@end
