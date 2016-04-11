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

#import <SMS_SDK/SMSSDK.h>

#define kDistance 10
#define kTextFieldHeight 44
@interface YRRegistViewController ()<CWSReadPolicyViewDelegate>

@property (nonatomic, strong) UITextField *tellText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) JKCountDownButton *getCodeBtn;
@property (nonatomic, strong) CWSPublicButton *registBtn;//注册按钮
@property (nonatomic, strong) CWSReadPolicyView *readPolicyView;

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
    self.codeText = [self setTextFieldWithFrame:CGRectMake(kDistance*2, CGRectGetMaxY(self.tellText.frame)+kDistance, kSizeOfScreen.width-4*kDistance, kTextFieldHeight) withPlaceholder:@"请输入验证码"];
    [self.view addSubview:self.codeText];
    
    self.registBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance*2, CGRectGetMaxY(self.codeText.frame)+kDistance, self.tellText.width, kTextFieldHeight)];
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
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:ws.tellText.text zone:@"86" customIdentifier:@"空钩的验证码" result:^(NSError *error) {
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
    [MBProgressHUD showMessag:@"提交中..." toView:self.view];
    [PublicCheckMsgModel checkTellWithTellNum:self.tellText.text complete:^(BOOL isSuccess) {
        if (![self.codeText.text isValid]) {
            MyLog(@"验证码不能为空");
            [MBProgressHUD showError:@"验证码不能为空" toView:self.view];

            return ;
        }
        [SMSSDK commitVerificationCode:self.codeText.text phoneNumber:self.tellText.text zone:@"86" result:^(NSError *error) {
            
            if (!error) {
                MyLog(@"短信验证成功");
                //检查手机号码是否注册
                [RequestData GET:USER_CHECK_TELL parameters:@{@"tel":self.tellText.text,@"kind":@"0"} complete:^(NSDictionary *responseDic) {
                    NSLog(@"%@",responseDic);
                    sender.userInteractionEnabled = YES;
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    if ([self.title isEqualToString:@"忘记密码"]) {//忘记密码
                        MyLog(@"手机号码没有注册");
                        return;
                    }
                    YRRegistPswController *pswVC = [[YRRegistPswController alloc]init];
                    pswVC.tellNum = self.tellText.text;
                    pswVC.codeNum = self.codeText.text;
                    [self.navigationController pushViewController:pswVC animated:YES];
                    
                } failed:^(NSError *error) {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    sender.userInteractionEnabled = YES;
                    if ([self.title isEqualToString:@"忘记密码"]) {//忘记密码
                        YRRegistPswController *pswVC = [[YRRegistPswController alloc]init];
                        pswVC.tellNum = self.tellText.text;
                        pswVC.codeNum = self.codeText.text;
                        [self.navigationController pushViewController:pswVC animated:YES];
                        return;
                    }
                    [MBProgressHUD showError:@"手机号码已注册" toView:GET_WINDOW];
                }];
            }
            else
            {
                MyLog(@"验证失败");
                [MBProgressHUD showError:@"验证失败" toView:self.view];
                sender.userInteractionEnabled = YES;
                [MBProgressHUD hideAllHUDsForView:self.view animated:self.view];
            }
        }];
    } error:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
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
