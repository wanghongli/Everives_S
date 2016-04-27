//
//  YRRegistViewController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/3/2.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRRegistViewController.h"
#import "CWSPublicButton.h"
#import "JKCountDownButton.h"
#import "CWSReadPolicyView.h"
#import "YRRegistPswController.h"
#import "YRProtocolViewController.h"
#import "PublicCheckMsgModel.h"
#import "CWSLoginTextField.h"
#import <SMS_SDK/SMSSDK.h>
#import "CWSLoginTextField.h"
#import "YRPerfectUserMsgController.h"
#import <RongIMKit/RongIMKit.h>

#define kDistance 10
#define kTextFieldHeight 44
@interface YRRegistViewController ()<CWSReadPolicyViewDelegate>
{
    NSMutableDictionary *_bodyDic;
}
@property (nonatomic, strong) UITextField *tellText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) JKCountDownButton *getCodeBtn;
@property (nonatomic, strong) CWSPublicButton *registBtn;//注册按钮
@property (nonatomic, strong) CWSReadPolicyView *readPolicyView;


@property (nonatomic, strong) CWSLoginTextField *passwordTextField;//密码

@property (nonatomic, strong) CWSLoginTextField *againPasswordTextField;//再次输入密码

@end

@implementation YRRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    
}
- (void)buildUI
{
    self.view.backgroundColor = kCOLOR(241, 241, 241);

    //手机号码输入框
    self.tellText = [self setTextFieldWithFrame:CGRectMake(kDistance*2, kDistance*2+64, kSizeOfScreen.width-4*kDistance, kTextFieldHeight) withPlaceholder:@"请输入您的手机号"];
    [self.view addSubview:self.tellText];
    
    
    //验证码
    self.codeText = [self setTextFieldWithFrame:CGRectMake(self.tellText.x, CGRectGetMaxY(self.tellText.frame)+kDistance, self.tellText.width, kTextFieldHeight) withPlaceholder:@"请输入验证码"];
    [self.view addSubview:self.codeText];
    
    
    //密码输入框
    self.passwordTextField = [self setPswTextFieldWithFrame:CGRectMake(self.tellText.x, CGRectGetMaxY(self.codeText.frame)+kDistance, self.tellText.width, kTextFieldHeight) withPlaceholder:@"请输入您的密码"];
    self.passwordTextField.secureTextEntry = YES;
    _passwordTextField.leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    
    [self.view addSubview:self.passwordTextField];
    
    //再次密码输入
    self.againPasswordTextField = [self setPswTextFieldWithFrame:CGRectMake(self.tellText.x, CGRectGetMaxY(self.passwordTextField.frame)+kDistance, self.tellText.width, kTextFieldHeight) withPlaceholder:@"请再次输入您的密码"];
    self.againPasswordTextField.secureTextEntry = YES;
    [self.view addSubview:self.againPasswordTextField];
    _againPasswordTextField.leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    
    self.registBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance*2, CGRectGetMaxY(self.againPasswordTextField.frame)+kDistance, self.tellText.width, kTextFieldHeight)];
    [self.registBtn setTitle:@"完成验证" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    
    if ([self.title isEqualToString:@"注册"]) {
        _readPolicyView = [[CWSReadPolicyView alloc]initWithFrame:CGRectMake(self.registBtn.x, self.registBtn.y+self.registBtn.height+20, kSizeOfScreen.width-30, 20)];
        _readPolicyView.delegate = self;
        [self.view addSubview:_readPolicyView];
    }
}
#pragma mark - 快速创建输入框
-(CWSLoginTextField *)setPswTextFieldWithFrame:(CGRect)frame withPlaceholder:(NSString *)placehold
{
    CWSLoginTextField *textField = [[CWSLoginTextField alloc]initWithFrame:frame];
    textField.placeholder = placehold;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, kTextFieldHeight)];
    return textField;
}
#pragma mark - 快速创建输入框
-(UITextField *)setTextFieldWithFrame:(CGRect)frame withPlaceholder:(NSString *)placehold
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placehold;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, kTextFieldHeight)];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = textField.height/2;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, 50, textField.height)];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:14];
    textField.leftView = leftLabel;
    if ([placehold isEqualToString:@"请输入您的手机号"]) {
        leftLabel.text = @"+86";

        //添加右侧获取验证码按钮
        self.getCodeBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(0, 0, 100, textField.height)];
        self.getCodeBtn.backgroundColor = [UIColor colorWithRed:31/255.0 green:158/255.0 blue:240/255.0 alpha:1];
        self.getCodeBtn.layer.masksToBounds = YES;
        self.getCodeBtn.layer.cornerRadius = self.getCodeBtn.height/2;
        self.getCodeBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.getCodeBtn.layer.borderWidth = 3;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        textField.rightView = self.getCodeBtn;
        //验证码获取
        WS(ws);
        [self.getCodeBtn addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
            if (![ws.tellText.text isVAlidPhoneNumber]) {
                [MBProgressHUD showError:@"手机号码有误" toView:GET_WINDOW];
                return;
            }
            sender.enabled = NO;
            sender.backgroundColor = [UIColor lightGrayColor];
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:ws.tellText.text zone:@"86" customIdentifier:@"蚁人约驾的验证码" result:^(NSError *error) {
                if (!error)
                {
                    MyLog(@"验证码发送成功");
                    [MBProgressHUD showSuccess:@"验证码发送成功" toView:GET_WINDOW];
                    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [sender startWithSecond:60];
                    
                    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                        NSString *title = [NSString stringWithFormat:@"重新发送(%d)",second];
                        return title;
                    }];
                    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                        countDownButton.enabled = YES;
                        [countDownButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        sender.backgroundColor = [UIColor colorWithRed:31/255.0 green:158/255.0 blue:240/255.0 alpha:1];
                        return @"重新发送";
                    }];
                }
                else
                {
                    sender.enabled = YES;
                    sender.backgroundColor = [UIColor colorWithRed:31/255.0 green:158/255.0 blue:240/255.0 alpha:1];
                    [MBProgressHUD showError:@"验证码发送失败" toView:GET_WINDOW];
                }
            }];
            
        }];
        textField.rightViewMode = UITextFieldViewModeAlways;
    }

    return textField;
}
#pragma mark - 注册事件
-(void)registClick:(CWSPublicButton *)sender
{
    sender.userInteractionEnabled = NO;
    [PublicCheckMsgModel checkTellWithTellNum:self.tellText.text complete:^(BOOL isSuccess) {
        if (![self.codeText.text isValid]) {
            MyLog(@"验证码不能为空");
            [MBProgressHUD showError:@"验证码不能为空" toView:self.view];
            sender.userInteractionEnabled = YES;
            return ;
        }
        [PublicCheckMsgModel checkPswIsEqualFistPsw:self.passwordTextField.text secondPsw:self.againPasswordTextField.text complete:^(BOOL isSuccess) {
            
            _bodyDic = [NSMutableDictionary dictionary];
            [_bodyDic setObject:self.tellText.text forKey:@"tel"];
            [_bodyDic setObject:self.codeText.text forKey:@"code"];
            [_bodyDic setObject:self.passwordTextField.text forKey:@"password"];
            [_bodyDic setObject:@"0" forKey:@"kind"];
            [_bodyDic setObject:@"1" forKey:@"type"];
            
            if (![self.title isEqualToString:@"注册"]) {//忘记密码跳转来
                [MBProgressHUD showMessag:@"修改中..." toView:self.view];
                [RequestData POST:USER_FIND_PSW parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [MBProgressHUD showSuccess:@"密码修改成功" toView:GET_WINDOW];
                    [self.navigationController popViewControllerAnimated:YES];
                } failed:^(NSError *error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    sender.userInteractionEnabled = NO;
                }];
                
            }else{//注册界面跳转而来
                [MBProgressHUD showMessag:@"注册中..." toView:self.view];
                [RequestData POST:USER_REGIST parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                    MyLog(@"%@",responseDic);
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    [self saveMsg:responseDic];
                    sender.userInteractionEnabled = NO;
                } failed:^(NSError *error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    sender.userInteractionEnabled = NO;
                }];
            }
        } error:^(NSString *errorMsg) {
            [MBProgressHUD showError:errorMsg toView:GET_WINDOW];
            sender.userInteractionEnabled = NO;
        }];
    } error:^(NSString *errorMsg) {
        sender.userInteractionEnabled = YES;
        [MBProgressHUD showError:errorMsg toView:self.view];
    }];
}
-(void)saveMsg:(NSDictionary *)responseDic
{
    YRUserStatus *user = [YRUserStatus mj_objectWithKeyValues:responseDic];
    NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
    [userDefaults setObject:responseDic forKey:@"user"];
    [userDefaults setObject:@{@"tel":self.tellText.text,@"psw":self.passwordTextField.text} forKey:@"loginCount"];
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
#pragma mark - 服务选项代理
//跳转到服务协议界面
-(void)readPolicyViewTurnToPolicyVC
{
    MyLog(@"%s",__func__);
    YRProtocolViewController*policyVC = [[YRProtocolViewController alloc]init];
    [self.navigationController pushViewController:policyVC animated:YES];
}
//是否选择协议
-(void)readPolicyViewTochDown:(BOOL)readOrPolicy
{
//    _readSelect = readOrPolicy;

}


@end
