//
//  YRStarLevelDetailView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRStarLevelDetailView.h"
@interface YRStarLevelDetailView ()

@property (nonatomic, strong) UILabel *levelLabel;

@end
@implementation YRStarLevelDetailView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    for (int i = 0; i<5; i++) {
        UIButton *btn = [[UIButton alloc]init];
        UIImage *normalImg = [UIImage imageNamed:@"Neig_Coach_StaGre"];
        UIImage *selectImg = [UIImage imageNamed:@"Neig_Coach_StaOrg"];
        [btn setImage:normalImg forState:UIControlStateNormal];
        [btn setImage:selectImg forState:UIControlStateSelected];
        btn.tag = i+10;
        [btn addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = NO;
        [self addSubview:btn];
    }
}
-(void)layoutSubviews
{
    for (int i = 0; i<5; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+10];
        CGFloat x = self.height*1.5*i;
        CGFloat y = 0;
        CGFloat wh = self.height;
        btn.frame = CGRectMake(x, y, wh, wh);
    }
}
-(void)setViewHeight:(CGFloat)viewHeight
{
    _viewHeight = viewHeight;
}
-(void)starClick:(UIButton *)sender
{
    for (int i = 0; i<5; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+10];
        if (sender.tag-10>=i) {
            btn.selected = YES;
        }else
            btn.selected = NO;
    }
    [self.delegate starLevelDetailViewWhichStarClick:sender.tag+1-10 with:self];
}
-(void)setStarNum:(NSInteger)starNum
{
    _starNum = starNum;
    for (int i = 0; i<5; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i+10];
        if (starNum>=i+1) {
            btn.selected = YES;
        }else
            btn.selected = NO;
    }
}
@end
