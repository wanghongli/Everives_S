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
//#import "YRPersonalDataController.h"
#import "YRPerfectUserMsgController.h"
#import "RequestData.h"
#import "PublicCheckMsgModel.h"
#import "CWSLoginTextField.h"
#import <RongIMKit/RongIMKit.h>

#define kDistance 10
#define kTextFieldHeight 44
@interface YRRegistPswController ()
{
    BOOL _pswOrRegistVC;//no 为注册跳转
    
    NSMutableDictionary *_bodyDic;
}
@property (nonatomic, strong) CWSLoginTextField *passwordTextField;//密码

@property (nonatomic, strong) CWSLoginTextField *againPasswordTextField;//再次输入密码

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
    _passwordTextField.leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];

    [self.view addSubview:self.passwordTextField];
    
    //再次密码输入
    self.againPasswordTextField = [self setTextFieldWithFrame:CGRectMake(kDistance, CGRectGetMaxY(self.passwordTextField.frame)+kDistance, kSizeOfScreen.width-2*kDistance, kTextFieldHeight) withPlaceholder:@"请再次输入您的密码"];
    self.againPasswordTextField.secureTextEntry = YES;
    [self.view addSubview:self.againPasswordTextField];
    _againPasswordTextField.leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];

    
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
-(CWSLoginTextField *)setTextFieldWithFrame:(CGRect)frame withPlaceholder:(NSString *)placehold
{
    CWSLoginTextField *textField = [[CWSLoginTextField alloc]initWithFrame:frame];
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
            [MBProgressHUD showMessag:@"修改中..." toView:self.view];

            [_bodyDic setObject:self.passwordTextField.text forKey:@"password"];
            
            [RequestData POST:USER_FIND_PSW parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"密码修改成功" toView:GET_WINDOW];
                [self.navigationController popToRootViewControllerAnimated:YES];
            } failed:^(NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"密码修改失败" toView:GET_WINDOW];
            }];
            
        }else{//注册界面跳转而来
            [MBProgressHUD showMessag:@"注册中..." toView:self.view];
            
            [_bodyDic setObject:self.passwordTextField.text forKey:@"password"];
            
            [RequestData POST:USER_REGIST parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                MyLog(@"%@",responseDic);
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [self saveMsg:responseDic];
            } failed:^(NSError *error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                [MBProgressHUD showSuccess:@"注册失败" toView:GET_WINDOW];
            }];
            
        }
    } error:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    
}
-(void)saveMsg:(NSDictionary *)responseDic
{
    YRUserStatus *user = [YRUserStatus mj_objectWithKeyValues:responseDic];
    NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
    [userDefaults setObject:responseDic forKey:@"user"];
    [userDefaults setObject:@{@"tel":self.tellNum,@"psw":self.passwordTextField.text} forKey:@"loginCount"];
    [NSUserDefaults resetStandardUserDefaults];
    
    
    KUserManager = user;
    //连接融云服务器
    [[RCIM sharedRCIM] connectWithToken:KUserManager.rongToken success:^(NSString *userId) {
        // Connect 成功
        NSLog(@"融云链接成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            YRPerfectUserMsgController *personalVC = [[YRPerfectUserMsgController alloc]init];
            personalVC.title = @"完善个人资料";
            [self.navigationController pushViewController:personalVC animated:YES];
            [MBProgressHUD showSuccess:@"注册成功" toView:GET_WINDOW];
        });
    }
                                  error:^(RCConnectErrorCode status) {
                                      NSLog(@"error_status = %ld",status);
                                  }
                         tokenIncorrect:^() {
                             NSLog(@"token incorrect");
                         }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
