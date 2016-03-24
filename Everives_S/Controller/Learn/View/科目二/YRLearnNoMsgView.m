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
        self.backgroundColor = [UIColor whiteColor];
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{

    UIImageView *imgview = [[UIImageView alloc]init];
    imgview.image = [UIImage imageNamed:@"learn_no_msg"];
    [self addSubview:imgview];
    _imgView = imgview;
    
    UIButton *turnbtn = [[UIButton alloc]init];
    [turnbtn setTitleColor:kCOLOR(77, 78, 79) forState:UIControlStateNormal];
    [turnbtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [turnbtn setTitle:@"现在就去认证吧！" forState:UIControlStateNormal];
    [self addSubview:turnbtn];
    _turnBtn = turnbtn;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgView.frame = CGRectMake(self.width*0.2, self.height/7, self.width*0.6, self.width*0.6);
    
    _turnBtn.frame = CGRectMake(0, self.height-self.height/7-40, kScreenWidth, 40);
}
-(void)btnClick
{
    MyLog(@"%s",__func__);
    [self.delegate learnNoMsgViewAttestationClick];
}

@end
