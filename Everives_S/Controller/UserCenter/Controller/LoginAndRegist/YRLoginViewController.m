//
//  YRLoginViewController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/3/2.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRLoginViewController.h"
#import "CWSLoginTextField.h"
#import "CWSPublicButton.h"
#import "UIButton+titleFrame.h"

#import "YRRegistViewController.h"
#import "PublicCheckMsgModel.h"
#import "YRPerfectUserMsgController.h"
#import <RongIMKit/RongIMKit.h>

#import "MJExtension.h"
#import "YRUserStatus.h"
#define CWSPercent 0.5
#define CWSLeftDistance 15*2
#define CWSHeightDistance ([[UIScreen mainScreen]applicationFrame].size.height -64)*0.03961268
@interface YRLoginViewController ()

@property (nonatomic, strong) UIImageView *iconImgView;//大图片
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) CWSLoginTextField *phoneTF;//手机号码输入框
@property (nonatomic, strong) CWSLoginTextField *passwordTF;//密码输入框
@property (nonatomic, strong) CWSPublicButton *sureBtn;//登录按钮
@property (nonatomic, strong) UIButton *forgetPassWordBtn;//忘记密码按钮
@property (nonatomic, strong) UIButton *registBtn;//注册按钮

@end

@implementation YRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建视图
    [self setUI];
}

#pragma mark - 创建视图
- (void)setUI
{
    //设置返回按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back"] target:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    //logo
    CGFloat weight = kSizeOfScreen.height*(1-CWSPercent) > kSizeOfScreen.width ? kSizeOfScreen.width : kSizeOfScreen.height*(1-CWSPercent);
    _iconImgView = [[UIImageView alloc]init];
    [self.view addSubview:_iconImgView];
    _iconImgView.frame = CGRectMake(0,CWSHeightDistance-64,weight*0.3, weight*0.3);
    _iconImgView.center = CGPointMake(kSizeOfScreen.width/2, kSizeOfScreen.height*(1-CWSPercent)/3);
    _iconImgView.image = [UIImage imageNamed:@"logo圆角版1"];
    
    //标题
    _titleLabel = [[UILabel alloc]init];
    [self.view addSubview:_titleLabel];
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconImgView.frame)+CWSHeightDistance, kSizeOfScreen.width, 30);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"蚁人约驾（学员）";
    
    //手机号码
    _phoneTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(CWSLeftDistance, kSizeOfScreen.height*0.4, kSizeOfScreen.width - 2 * CWSLeftDistance, 44)];
    _phoneTF.leftImage = [UIImage imageNamed:@"Login_UsernameGray"];
    _phoneTF.placeholder = @"手机号码";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_phoneTF];
    
    //密码
    _passwordTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(CWSLeftDistance, _phoneTF.y + _phoneTF.height + CWSHeightDistance, kSizeOfScreen.width - 2 * CWSLeftDistance, 44)];
    _passwordTF.leftImage = [UIImage imageNamed:@"Login_PasswordGray"];
    _passwordTF.placeholder = @"密码";
    _passwordTF.secureTextEntry = YES;
    [self.view addSubview:_passwordTF];
    
    //登录按钮
    _sureBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(CWSLeftDistance, _passwordTF.y + _passwordTF.height + CWSHeightDistance, kSizeOfScreen.width - 2 * CWSLeftDistance, 44)];
    [_sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
    //忘记密码
//    _forgetPassWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(CWSLeftDistance, kSizeOfScreen.height-30 + 20, 80, 30)];
    _forgetPassWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(CWSLeftDistance, CGRectGetMaxY(_sureBtn.frame)+CWSHeightDistance, 80, 30)];

    [_forgetPassWordBtn setFrameWithTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPassWordBtn addTarget:self action:@selector(forgetPassWordClick:) forControlEvents:UIControlEventTouchUpInside];
    [_forgetPassWordBtn setTitleColor:kCOLOR(135, 135, 135) forState:UIControlStateNormal];
    [self.view addSubview:_forgetPassWordBtn];
    
    //新用户注册
    _registBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSizeOfScreen.width - CWSLeftDistance, _forgetPassWordBtn.y, 0, 30)];
    [_registBtn setFrameWithTitle:@"新用户注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
    [_registBtn setTitleColor:kCOLOR(19, 19, 19) forState:UIControlStateNormal];

}
#pragma mark - 登录事件
- (void)loginClick:(CWSPublicButton*)sender
{
    MyLog(@"%s",__func__);
    [PublicCheckMsgModel loginMsgCheckTell:self.phoneTF.text psw:self.passwordTF.text complete:^(BOOL isSuccess) {
        [MBProgressHUD showMessag:@"正在登陆" toView:self.view];
        [RequestData POST:USER_LOGIN parameters:@{@"tel":self.phoneTF.text,@"password":self.passwordTF.text,@"kind":@"0",@"type":@"1"} complete:^(NSDictionary *responseDic) {
            NSLog(@"%@",responseDic);
            YRUserStatus *user = [YRUserStatus mj_objectWithKeyValues:responseDic];
            NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
            [userDefaults setObject:responseDic forKey:@"user"];
            [userDefaults setObject:@{@"tel":self.phoneTF.text,@"psw":self.passwordTF.text} forKey:@"loginCount"];
            [NSUserDefaults resetStandardUserDefaults];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            KUserManager = user;
            //连接融云服务器
            [[RCIM sharedRCIM] connectWithToken:KUserManager.rongToken success:^(NSString *userId) {
                // Connect 成功
                NSLog(@"融云链接成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        [MBProgressHUD showSuccess:@"登陆成功" toView:GET_WINDOW];
                    }];
                });
            }
                                          error:^(RCConnectErrorCode status) {
                                              MyLog(@"error_status = %ld",status);
                                              [userDefaults removeObjectForKey:@"user"];
                                              [userDefaults removeObjectForKey:@"loginCount"];
                                              [NSUserDefaults resetStandardUserDefaults];
                                              KUserManager.id = nil;
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                              [MBProgressHUD showError:@"登陆失败，请重新登陆" toView:self.view];
                                          });
                                          }
                                 tokenIncorrect:^() {
                                     [userDefaults removeObjectForKey:@"user"];
                                     [userDefaults removeObjectForKey:@"loginCount"];
                                     [NSUserDefaults resetStandardUserDefaults];
                                     KUserManager.id = nil;
                                     MyLog(@"token incorrect");
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [MBProgressHUD showError:@"登陆失败，请重新登陆" toView:self.view];
                                     });
                                 }];
            
        } failed:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    } error:^(NSString *errorMsg) {//账号密码有误
        NSLog(@"%@",errorMsg);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:errorMsg toView:self.view];
    }];
    
}
#pragma mark - 忘记密码事件
- (void)forgetPassWordClick:(UIButton *)sender
{
    MyLog(@"%s",__func__);
    YRRegistViewController *registVC = [[YRRegistViewController alloc]init];
    registVC.title = @"忘记密码";
    [self.navigationController pushViewController:registVC animated:YES];
}
#pragma mark - 注册事件
- (void)registClick:(UIButton *)sender
{
    MyLog(@"%s",__func__);
    YRRegistViewController *registVC = [[YRRegistViewController alloc]init];
    registVC.title = @"注册";
    [self.navigationController pushViewController:registVC animated:YES];
//    YRPerfectUserMsgController *msgVC = [[YRPerfectUserMsgController alloc]init];
//    [self.navigationController pushViewController:msgVC animated:YES];
}
#pragma mark - 返回事件
-(void)backClick
{
    MyLog(@"%s",__func__);
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
