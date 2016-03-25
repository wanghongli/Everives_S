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
#import "PublicCheckMsgModel.h"
#define kDistance 30
@interface YRCertificationController ()

@property (nonatomic, strong) CWSLoginTextField *nameTF;//姓名
@property (nonatomic, strong) CWSLoginTextField *idCardTF;//身份证
@property (nonatomic, strong) CWSPublicButton *sureBtn; //确认信息

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
    _nameTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistance, kDistance+64, kSizeOfScreen.width - 2 * kDistance, 44)];
    _nameTF.leftImage = [UIImage imageNamed:@"Neighborhood_Field_Contacts"];
    _nameTF.placeholder = @"请输入真实姓名";
    [self.view addSubview:_nameTF];
    
    //身份证
    _idCardTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(_nameTF.frame)+kDistance/2, kSizeOfScreen.width - 2 * kDistance, 44)];
    _idCardTF.leftImage = [UIImage imageNamed:@"Identification_IDcardBlack"];
    _idCardTF.placeholder = @"请输入您的身份证号码";
    [self.view addSubview:_idCardTF];
    
    _sureBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(_idCardTF.frame)+kDistance/2,  kSizeOfScreen.width - 2 * kDistance, 40)];
//    [_sureBtn setFrameWithTitle:@"确认信息" forState:UIControlStateNormal];
    [_sureBtn setTitle:@"确认信息" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
    _certificationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreenHeight - kScreenHeight/8, kScreenWidth, 44)];
    [_certificationBtn setTitle:@"为什么要进行信息认证？" forState:UIControlStateNormal];
    [_certificationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_certificationBtn addTarget:self action:@selector(certificationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_certificationBtn];
    
}

#pragma mark - 确认信息
-(void)registClick:(CWSPublicButton *)sender
{
    [PublicCheckMsgModel checkName:self.nameTF.text idCard:self.idCardTF.text complete:^(BOOL isSuccess) {
        [RequestData POST:STUDENT_IDENTIFY parameters:@{@"realname":self.nameTF.text,@"peopleId":self.idCardTF.text} complete:^(NSDictionary *responseDic) {
            [MBProgressHUD showSuccess:@"认证成功" toView:GET_WINDOW];
            [self.navigationController popViewControllerAnimated:YES];
        } failed:^(NSError *error) {
            [MBProgressHUD showError:@"认证失败" toView:GET_WINDOW];
        }];
    } error:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg toView:GET_WINDOW];
    }];
}
#pragma mark - 为什么要信息信息认证
-(void)certificationClick:(UIButton *)sender
{
    MyLog(@"%s----%s",__FILE__,__func__);
}

@end
