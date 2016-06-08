//
//  YRCertificationController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/24.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCertificationController.h"
#import "YRUserCenterViewController.h"
#import "CWSLoginTextField.h"
#import "CWSPublicButton.h"
#import "UIButton+titleFrame.h"
#import "PublicCheckMsgModel.h"
#define kDistance 30
@interface YRCertificationController ()

@property (nonatomic, strong) CWSLoginTextField *nameTF;//姓名
@property (nonatomic, strong) CWSLoginTextField *idCardTF;//身份证


@property (nonatomic, strong) UIButton *certificationBtn;//为什么信息认证
@end

@implementation YRCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
}
- (void)buildUI
{
    //姓名
    _nameTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistance, kDistance, kSizeOfScreen.width - 2 * kDistance, 44)];
    _nameTF.leftImage = [UIImage imageNamed:@"Neighborhood_Field_Contacts"];
    _nameTF.placeholder = @"请输入真实姓名";
    _nameTF.text = KUserManager.realname;
    [self.view addSubview:_nameTF];
    
    //身份证
    _idCardTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(_nameTF.frame)+kDistance/2, kSizeOfScreen.width - 2 * kDistance, 44)];
    _idCardTF.leftImage = [UIImage imageNamed:@"Identification_IDcardBlack"];
    _idCardTF.placeholder = @"请输入您的身份证号码";
    _idCardTF.text = KUserManager.peopleId;
    [self.view addSubview:_idCardTF];
    
    
    _certificationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight - kScreenHeight/8-64, kScreenWidth, 44)];
    [_certificationBtn setTitle:@"为什么要进行信息认证？" forState:UIControlStateNormal];
    [_certificationBtn setTitleColor:[UIColor colorWithRed:0 green:0 blue:93/255.0 alpha:1] forState:UIControlStateNormal];
    _certificationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_certificationBtn addTarget:self action:@selector(certificationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_certificationBtn];
    MyLog(@"%ld",KUserManager.status);
    if (KUserManager.status) {//提交过
        _nameTF.text = KUserManager.realname;
        _idCardTF.text = KUserManager.peopleId;
    }
}


#pragma mark - 为什么要信息信息认证
-(void)certificationClick:(UIButton *)sender
{
    MyLog(@"%s----%s",__FILE__,__func__);
}

@end
