//
//  YRLearnNoMsgView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnNoMsgView.h"
@interface YRLearnNoMsgView ()

@property (nonatomic, weak) UIImageView *imgView;

@property (nonatomic, weak) UIButton *turnBtn;

@end
@implementation YRLearnNoMsgView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{

    UIImageView *imgview = [[UIImageView alloc]init];
    [self addSubview:imgview];
    _imgView = imgview;
    
    UIButton *turnbtn = [[UIButton alloc]init];
    [turnbtn setTitleColor:kCOLOR(77, 78, 79) forState:UIControlStateNormal];
    [turnbtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:turnbtn];
    _turnBtn = turnbtn;
    
}

-(void)btnClick
{
    MyLog(@"%s",__func__);
}

@end
