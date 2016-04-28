//
//  YRPerfectHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPerfectHeadView.h"
@interface YRPerfectHeadView ()

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nomaLabel;

@property (nonatomic, strong) UIButton *chooseImgBtn;

@property (nonatomic, strong) UIButton *backBtn;

@end
@implementation YRPerfectHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    
    _headImg = [[UIImageView alloc]init];
    _headImg.frame = CGRectMake(0, 0    ,self.height*0.4, self.height*0.4);
    _headImg.center = CGPointMake(self.width/2, self.height/2+10);
    _headImg.image = [UIImage imageNamed:kPLACEHHOLD_IMG];
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.width/2;
    [self addSubview:_headImg];
    
    _nomaLabel = [[UILabel alloc]init];
    _nomaLabel.frame = CGRectMake(0, CGRectGetMaxY(_headImg.frame), self.width, self.height - CGRectGetMaxY(_headImg.frame));
    _nomaLabel.font = [UIFont systemFontOfSize:14];
    _nomaLabel.text = @"注册成功，快去完善资料吧！";
    _nomaLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nomaLabel];
    
//    _chooseImgBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.height-30)];
    _chooseImgBtn = [[UIButton alloc]initWithFrame:_headImg.frame];
    [_chooseImgBtn addTarget:self action:@selector(chooseClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_chooseImgBtn];
    [self bringSubviewToFront:_chooseImgBtn];
}

-(void)setUserImg:(UIImage *)userImg
{
    _userImg = userImg;
    _headImg.image = userImg;
}

-(void)chooseClick
{
    [self.delegate perfectHeadViewChooseImg];
}
@end
