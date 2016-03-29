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

@end
@implementation YRExamUserHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
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
    
    _nameLabel.text = @"玉祥驾校";
    _headImg.image = [UIImage imageNamed:@"head_jiaolian"];
    
    _headImg.layer.masksToBounds = YES;
    _headImg.layer.cornerRadius = _headImg.height/2;
    
    if (KUserManager.id) {
        _nameLabel.text = KUserManager.name;
        [_headImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:@"head_jiaolian"]];
    }
}

@end
