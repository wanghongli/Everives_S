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
#import "RequestData.h"
#import "PublicCheckMsgModel.h"
#define kDistance 10
#define kTextFieldHeight 44
@interface YRRegistPswController ()
{
    BOOL _pswOrRegistVC;//no 为注册跳转
    
    NSMutableDictionary *_bodyDic;
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
    _bodyDic = [NSMutableDictionary dictionary];
    [_bodyDic setObject:self.tellNum forKey:@"tel"];
    [_bodyDic setObject:self.codeNum forKey:@"code"];
    [_bodyDic setObject:@"0" forKey:@"kind"];
    [_bodyDic setObject:@"1" forKey:@"type"];
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
    [PublicCheckMsgModel checkPswIsEqualFistPsw:self.passwordTextField.text secondPsw:self.againPasswordTextField.text complete:^(BOOL isSuccess) {
        if (_pswOrRegistVC) {//忘记密码跳转来
           
            [_bodyDic setObject:self.passwordTextField.text forKey:@"password"];
            
            [RequestData POST:USER_FIND_PSW parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } failed:^(NSError *error) {
                
            }];
            
        }else{//注册界面跳转而来
            
            [_bodyDic setObject:self.passwordTextField.text forKey:@"password"];
            
            [RequestData POST:USER_REGIST parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                NSLog(@"%@",responseDic);
                
//                YRPersonalDataController *personalVC = [[YRPersonalDataController alloc]initWithNibName:@"YRPersonalDataController" bundle:nil];
//                personalVC.title = @"完善个人资料";
//                [self.navigationController pushViewController:personalVC animated:YES];

                [self.navigationController popToRootViewControllerAnimated:YES];
            } failed:^(NSError *error) {
                
            }];
            
        }
    } error:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
