//
//  YRScroeDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/5/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRScroeDownView.h"

#define kToTopDestace 20

@interface YRScroeDownView ()
@property (nonatomic, strong) UIButton *errorBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@end
@implementation YRScroeDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.errorBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}
-(void)btnClick:(UIButton *)sender
{
    [self.delegate scroeDownViewClick:sender.tag];
}
-(UIButton *)errorBtn
{
    if (!_errorBtn) {
        _errorBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.15,kToTopDestace, (kScreenWidth*0.7-kToTopDestace)/2, 40)];
        [_errorBtn setTitle:@"查看错题" forState:UIControlStateNormal];
        [_errorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _errorBtn.backgroundColor = kCOLOR(71, 71, 71);
        _errorBtn.titleLabel.font = kFontOfLetterBig;
        _errorBtn.layer.masksToBounds = YES;
        _errorBtn.tag = 11;
        _errorBtn.layer.cornerRadius = _errorBtn.height/2;
        [self addSubview:_errorBtn];
    }
    return _errorBtn;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_errorBtn.frame)+kToTopDestace, _errorBtn.y, (kScreenWidth*0.7-kToTopDestace)/2, _errorBtn.height)];
        [_shareBtn setTitle:@"分享成绩" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kCOLOR(71, 71, 71) forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = kFontOfLetterBig;
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.layer.cornerRadius = _errorBtn.height/2;
        _shareBtn.layer.borderColor = kCOLOR(71, 71, 71).CGColor;
        _shareBtn.layer.borderWidth = 1;
        _shareBtn.tag = 12;
        [self addSubview:_shareBtn];
    }
    return _shareBtn;
}
@end
