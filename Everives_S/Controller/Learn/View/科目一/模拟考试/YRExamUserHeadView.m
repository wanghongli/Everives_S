//
//  YRExamUserHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/24.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamUserHeadView.h"
#import "UIImageView+WebCache.h"

@interface YRExamUserHeadView ()

@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIButton *btn;
@end
@implementation YRExamUserHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        self.userInteractionEnabled = YES;
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    UIView *backview = [[UIView alloc]init];
    [self addSubview:backview];
    _backView = backview;
    
    UIImageView *headimg = [[UIImageView alloc]init];
    [_backView addSubview:headimg];
    _headImg = headimg;
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = kFontOfLetterBig;
    namelabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:namelabel];
    _nameLabel = namelabel;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self addGestureRecognizer:tapGestureRecognizer];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _headImg.frame = CGRectMake(0, 0, self.height/2, self.height/2);
    CGSize nameSize = [@"asdf" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLabel.frame = CGRectMake(0, CGRectGetMaxY(_headImg.frame)+10, kScreenWidth, nameSize.height);
    
    _backView.frame = CGRectMake(0, 0, kScreenWidth, CGRectGetMaxY(_nameLabel.frame));
    _backView.center = CGPointMake(kScreenWidth/2, self.height/2);
    _headImg.center = CGPointMake(kScreenWidth/2, _headImg.center.y);
    
    _nameLabel.text = @"未登录";
    _headImg.image = [UIImage imageNamed:@"User_Placeholder"];
    
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.height/2;
    _headImg.layer.borderWidth = 1;
    _headImg.layer.borderColor = kCOLOR(241, 241, 241).CGColor;
    if (KUserManager.id) {
        _nameLabel.text = KUserManager.name;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:@"User_Placeholder"]];
    }
}
-(void)setLoginBool:(BOOL)loginBool
{
    if (KUserManager.id) {
        _nameLabel.text = KUserManager.name;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:@"User_Placeholder"]];
    }else{
        _nameLabel.text = @"未登录";
        _headImg.image = [UIImage imageNamed:@"User_Placeholder"];
    }
}
-(void)keyboardHide{
    if (!KUserManager.id) {
        [self.delegate examUserHeadClick];
    }
}
@end
