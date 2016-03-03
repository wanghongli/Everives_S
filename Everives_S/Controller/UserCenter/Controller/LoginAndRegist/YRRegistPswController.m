//
//  YRYJRegistPswController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRRegistPswController.h"
#import "CWSPublicButton.h"
#import "YRRegistViewController.h"
#import "YRPersonalDataController.h"
#define kDistance 10
#define kTextFieldHeight 44
@interface YRRegistPswController ()
{
    BOOL _pswOrRegistVC;//no 为注册跳转
}
@property (nonatomic, strong) UITextField *passwordTextField;//密码

@property (nonatomic, strong) UITextField *againPasswordTextField;//再次输入密码

@property (nonatomic, strong) CWSPublicButton *registBtn;//注册按钮

@end

@implementation YRRegistPswController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认密码";
    
    [self buildUI];
}

-(void)buildUI
{
    //密码输入框
    self.passwordTextField = [self setTextFieldWithFrame:CGRectMake(kDistance, kDistance*2+64, kSizeOfScreen.width-2*kDistance, kTextFieldHeight) withPlaceholder:@"请输入您的密码"];
    self.passwordTextField.secureTextEntry = YES;
    [self.view addSubview:self.passwordTextField];
    
    //再次密码输入
    self.againPasswordTextField = [self setTextFieldWithFrame:CGRectMake(kDistance, CGRectGetMaxY(self.passwordTextField.frame)+kDistance, kSizeOfScreen.width-2*kDistance, kTextFieldHeight) withPlaceholder:@"请再次输入您的密码"];
    self.againPasswordTextField.secureTextEntry = YES;
    [self.view addSubview:self.againPasswordTextField];
    
    self.registBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(self.againPasswordTextField.frame)+2*kDistance, self.againPasswordTextField.width, kTextFieldHeight)];
    
    if ([[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2] isKindOfClass:[YRRegistViewController class]]) {
        YRRegistViewController *registVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
        if ([registVC.title isEqualToString:@"注册"]) {
            [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
            _pswOrRegistVC = NO;
        }else{
            [self.registBtn setTitle:@"确定" forState:UIControlStateNormal];
            _pswOrRegistVC = YES;
        }
    }
    
    [self.registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
}

#pragma mark - 快速创建输入框
-(UITextField *)setTextFieldWithFrame:(CGRect)frame withPlaceholder:(NSString *)placehold
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placehold;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, kTextFieldHeight)];
    return textField;
}

#pragma  - 注册按钮
- (void)registClick:(CWSPublicButton *)sender
{
    
    if (_pswOrRegistVC) {
        
    }else{
        YRPersonalDataController *personalVC = [[YRPersonalDataController alloc]initWithNibName:@"YRPersonalDataController" bundle:nil];
        personalVC.title = @"完善个人资料";
        [self.navigationController pushViewController:personalVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
