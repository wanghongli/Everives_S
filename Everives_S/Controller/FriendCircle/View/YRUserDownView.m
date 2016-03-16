//
//  YRUserDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserDownView.h"

#define  kDistance 10
@interface YRUserDownView ()
@property (nonatomic, weak) UIButton *sendMsgBtn;
@property (nonatomic, weak) UIButton *getTeacherBtn;
@end
@implementation YRUserDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    UIButton *sendmsgbtn = [[UIButton alloc]init];
    [sendmsgbtn setTitle:@"发消息" forState:UIControlStateNormal];
    [sendmsgbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [sendmsgbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendmsgbtn.backgroundColor = kCOLOR(53, 53, 53);
    sendmsgbtn.tag = 10;
    [self addSubview:sendmsgbtn];
    _sendMsgBtn = sendmsgbtn;
    
    UIButton *getteacherbtn = [[UIButton alloc]init];
    [getteacherbtn setTitle:@"拼教练" forState:UIControlStateNormal];
    [getteacherbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [getteacherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getteacherbtn.backgroundColor = kCOLOR(53, 53, 53);
    getteacherbtn.tag = 11;
    [self addSubview:getteacherbtn];
    _getTeacherBtn = getteacherbtn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _sendMsgBtn.frame = CGRectMake(kDistance, 0, self.width - 2*kDistance, (self.height-kDistance)/2);
    _sendMsgBtn.layer.masksToBounds = YES;
    _sendMsgBtn.layer.cornerRadius = _sendMsgBtn.height/2;
    
    _getTeacherBtn.frame = CGRectMake(_sendMsgBtn.x, CGRectGetMaxY(_sendMsgBtn.frame)+kDistance, _sendMsgBtn.width, _sendMsgBtn.height);
    _getTeacherBtn.layer.masksToBounds = YES;
    _getTeacherBtn.layer.cornerRadius = _getTeacherBtn.height/2;
}
-(void)btnClick:(UIButton *)sender
{
    [self.delegate userDownViewBtnTag:sender.tag-10];
}
@end
