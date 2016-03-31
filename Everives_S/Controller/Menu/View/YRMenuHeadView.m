//
//  YRMenuHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMenuHeadView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"

#define kDistace 10
@interface YRMenuHeadView ()
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) UIImageView *sexImg;
@property (nonatomic, strong) UIButton *notiBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@end
@implementation YRMenuHeadView

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
    UIImageView *headview = [[UIImageView alloc]init];
    [self addSubview:headview];
    _headImg = headview;
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = [UIFont systemFontOfSize:18];
    namelabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    UILabel *signlabel = [[UILabel alloc]init];
    signlabel.font = [UIFont systemFontOfSize:14];
    signlabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:signlabel];
    _signLabel = signlabel;
    
    _notiBtn = [[UIButton alloc]init];
    [_notiBtn addTarget:self action:@selector(notiClick:) forControlEvents:UIControlEventTouchUpInside];
    [_notiBtn setImage:[UIImage imageNamed:@"alarm_img"] forState:UIControlStateNormal];
    [self addSubview:_notiBtn];
    
    UIButton *loginbtn = [[UIButton alloc]init];
    [loginbtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginbtn];
    _loginBtn = loginbtn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat wh = (self.height-20)*2/3;
    _headImg.frame = CGRectMake(kDistace, wh/4+20, wh, wh);
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = wh/2;
    _headImg.image = [UIImage imageNamed:KUSER_HEAD_IMG];
    
    NSString *nameString = @"玉祥驾校";
    CGSize nameSize = [nameString sizeWithFont:[UIFont systemFontOfSize:18] maxSize:CGSizeMake(self.width/2, wh/2)];
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headImg.frame)+kDistace, _headImg.y+kDistace/2, nameSize.width, wh/2);
    _nameLabel.text = nameString;
    
    NSString *signString = @"学车好难...";
    CGSize signSize = [signString sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(self.width/2, wh/2)];
    _signLabel.frame = CGRectMake(_nameLabel.x, CGRectGetMaxY(_nameLabel.frame)-kDistace/2, signSize.width, wh/2);
    _signLabel.text = signString;
    
    _notiBtn.frame = CGRectMake(self.width-wh*2/3-kDistace, _headImg.y+wh/6, wh*2/3, wh*2/3);
    _notiBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    _loginBtn.frame = CGRectMake(CGRectGetMaxX(_headImg.frame)+kDistace, _headImg.y, 60, _headImg.height);
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    _loginBtn.titleLabel.textColor = [UIColor blackColor];
    
    
    if (KUserManager.id) {
        _nameLabel.text = KUserManager.name;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:KUSER_HEAD_IMG]];
        _signLabel.text = KUserManager.sign;
        
    }
}
-(void)setLoginBool:(BOOL)loginBool
{
    _loginBool = loginBool;
    
    if (loginBool) {//已经登陆
        _nameLabel.text = KUserManager.name;
        _loginBtn.hidden = YES;
        _signLabel.hidden = NO;
        _nameLabel.hidden = NO;
        _notiBtn.hidden = NO;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:KUSER_HEAD_IMG]];
        
    }else{//没有登陆
        _loginBtn.hidden = NO;
        _nameLabel.hidden = YES;
        _signLabel.hidden = YES;
        _notiBtn.hidden = YES;
        _headImg.image = [UIImage imageNamed:KUSER_HEAD_IMG];
    }
}
-(void)loginClick:(UIButton *)sender
{
    [self.delegate menuHeadViewLoginClick];
}
-(void)notiClick:(UIButton *)sender
{
    MyLog(@"消息中心");
    [self.delegate menuHeadViewNotiClick];
}

@end
