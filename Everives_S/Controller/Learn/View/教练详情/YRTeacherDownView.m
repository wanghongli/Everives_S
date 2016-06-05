//
//  YRTeacherDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherDownView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface YRTeacherDownView ()

@property (nonatomic, weak) UIButton *attentionBtn;
@property (nonatomic, weak) UIButton *appointmentBtn;
@property (nonatomic, weak) UIView *middleLine;
@property (nonatomic, weak) UIView *topLine;
@end
@implementation YRTeacherDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    
    UIButton *attentionbtn = [[UIButton alloc]init];
    [attentionbtn setTitle:@" 关注" forState:UIControlStateNormal];
    attentionbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [attentionbtn setImage:[UIImage imageNamed:@"Neig_Coach_AddContac"] forState:UIControlStateNormal];
    [attentionbtn addTarget:self action:@selector(downViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [attentionbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    attentionbtn.tag = 11;
    [self addSubview:attentionbtn];
    _attentionBtn = attentionbtn;
    
    UIButton *appointmentbtn = [[UIButton alloc]init];
    [appointmentbtn setTitle:@" 预约" forState:UIControlStateNormal];
    appointmentbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [appointmentbtn setImage:[UIImage imageNamed:@"Neig_Coach_Bespeak"] forState:UIControlStateNormal];
    [appointmentbtn addTarget:self action:@selector(downViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    appointmentbtn.tag = 12;
    [appointmentbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:appointmentbtn];
    _appointmentBtn = appointmentbtn;
    
    UIView *middleline = [[UIView alloc]init];
    middleline.backgroundColor = kCOLOR(220, 221, 222);
    [self addSubview:middleline];
    _middleLine = middleline;
    
    UIView *topline = [[UIView alloc]init];
    topline.backgroundColor = kCOLOR(220, 221, 222);
    [self addSubview:topline];
    _topLine = topline;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _attentionBtn.frame = CGRectMake(0, 0, kScreenWidth/2-1, self.height);
    _appointmentBtn.frame = CGRectMake(CGRectGetMaxX(_attentionBtn.frame)+1, 0, kScreenWidth/2, self.height);
    _middleLine.frame = CGRectMake(kScreenWidth/2, 5, 1, self.height-10);
    _topLine.frame = CGRectMake(0, 0, kScreenWidth, 1);
}
-(void)downViewBtnClick:(UIButton *)sender
{
    [self.delegate teacherDownViewBtnClick:sender.tag-10];
}
-(void)setAttentionBool:(BOOL)attentionBool
{
    _attentionBool = attentionBool;
    [_attentionBtn setTitle:attentionBool?@" 已关注":@" 关注" forState:UIControlStateNormal];
}
@end
