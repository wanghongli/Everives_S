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
@property (nonatomic, weak) UILabel *describLabel;
@property (nonatomic, weak) UIView *lineView;
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
    
    UILabel *describLabel = [[UILabel alloc]init];
    describLabel.textAlignment = NSTextAlignmentCenter;
    describLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:describLabel];
    _describLabel = describLabel;
    
    UIButton *turnbtn = [[UIButton alloc]init];
    [turnbtn setTitleColor:kCOLOR(77, 78, 79) forState:UIControlStateNormal];
    [turnbtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [turnbtn setTitle:@"现在就去认证吧！" forState:UIControlStateNormal];
    [self addSubview:turnbtn];
    _turnBtn = turnbtn;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    _lineView = lineView;
}
-(void)setBtnTitle:(NSString *)btnTitle
{
    _btnTitle = btnTitle;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _imgView.frame = CGRectMake(self.width*0.2, self.height/7, self.width*0.6, self.width*0.6);
    _describLabel.frame = CGRectMake(0, CGRectGetMaxY(_imgView.frame)+5, kScreenWidth, 20);
    _describLabel.text = _btnTitle;
    
    
    NSString *titleString;
    if ([_btnTitle isEqualToString:@"您的信息正在审核当中"]) {
        titleString = @"先去驾友圈看看吧!";
    }else if ([_btnTitle isEqualToString:@"抱歉，您还未进行信息认证"]){
        titleString = @"现在就去认证吧!";
    }else if ([_btnTitle isEqualToString:@"审核失败"]){
        titleString = @"重新认证";
    }
    
    CGSize btnSize = [titleString sizeWithFont:_turnBtn.titleLabel.font maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    [_turnBtn setTitle:titleString forState:UIControlStateNormal];
    _turnBtn.frame = CGRectMake(kScreenWidth/2-btnSize.width/2, self.height-self.height/7-40, btnSize.width, btnSize.height);
    
    _lineView.frame = CGRectMake(_turnBtn.x, CGRectGetMaxY(_turnBtn.frame)+2, _turnBtn.width, 1);
}
-(void)btnClick
{
    MyLog(@"%s",__func__);
    NSInteger i;
    if ([_btnTitle isEqualToString:@"您的信息正在审核当中"]) {
        i = 0;
    }else if ([_btnTitle isEqualToString:@"抱歉，您还未进行信息认证"]){
        i = 1;
    }else if ([_btnTitle isEqualToString:@"审核失败"]){
        i = 2;
    }
    [self.delegate learnNoMsgViewAttestationClickTag:i];
}

@end
