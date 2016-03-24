//
//  YRCertificationController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/24.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCertificationController.h"

#import "CWSLoginTextField.h"
#import "CWSPublicButton.h"
#import "UIButton+titleFrame.h"

#define kDistance 30
@interface YRCertificationController ()

@property (nonatomic, strong) CWSLoginTextField *nameTF;//姓名
@property (nonatomic, strong) CWSLoginTextField *idCardTF;//身份证
@property (nonatomic, strong) CWSPublicButton *sureBtn; //确认信息
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
    _nameTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistance, kDistance+64, kSizeOfScreen.width - 2 * kDistance, 44)];
    _nameTF.leftImage = [UIImage imageNamed:@"Neighborhood_Field_Contacts"];
    _nameTF.placeholder = @"请输入真实姓名";
    [self.view addSubview:_nameTF];
    
    //身份证
    _idCardTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(_nameTF.frame)+kDistance/2, kSizeOfScreen.width - 2 * kDistance, 44)];
    _idCardTF.leftImage = [UIImage imageNamed:@"Identification_IDcardBlack"];
    _idCardTF.placeholder = @"请输入您的身份证号码";
    [self.view addSubview:_idCardTF];
    
//    _sureBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(_idCardTF.frame)+kDistance/2,  kSizeOfScreen.width - 2 * kDistance, 30)];
//    [_sureBtn setFrameWithTitle:@"确认信息" forState:UIControlStateNormal];
//    [_sureBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_sureBtn];
}
-(void)registClick:(CWSPublicButton *)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
