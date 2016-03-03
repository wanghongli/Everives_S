//
//  YRYJRegistViewController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/3/2.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJRegistViewController.h"
#import "CWSPublicButton.h"
#import "JKCountDownButton.h"
#import "CWSReadPolicyView.h"
#define kDistance 10
#define kTextFieldHeight 44
@interface YRYJRegistViewController ()

@property (nonatomic, strong) UITextField *tellText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) JKCountDownButton *getCodeBtn;
@property (nonatomic, strong) CWSPublicButton *registBtn;//注册按钮
@property (nonatomic, strong) CWSReadPolicyView *readPolicyView;

@end

@implementation YRYJRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self buildUI];
    
}
- (void)buildUI
{
    self.view.backgroundColor = kCOLOR(241, 241, 241);

    //手机号码输入框
    self.tellText = [self setTextFieldWithFrame:CGRectMake(kDistance, kDistance*2+64, kSizeOfScreen.width-2*kDistance, kTextFieldHeight) withPlaceholder:@"请输入您的手机号"];
    [self.view addSubview:self.tellText];
    
    
    //验证码
    self.codeText = [self setTextFieldWithFrame:CGRectMake(kDistance, CGRectGetMaxY(self.tellText.frame)+kDistance, (kSizeOfScreen.width-2*kDistance)*0.66, kTextFieldHeight) withPlaceholder:@"请输入验证码"];
    [self.view addSubview:self.codeText];
    
    //添加右侧获取验证码按钮
    self.getCodeBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.codeText.frame)+kDistance, self.codeText.y, (kSizeOfScreen.width-2*kDistance)*0.36-kDistance, kTextFieldHeight)];
    self.getCodeBtn.backgroundColor = kMainColor;
    self.getCodeBtn.layer.masksToBounds = YES;
    self.getCodeBtn.layer.cornerRadius = 4;
    self.getCodeBtn.layer.borderColor = [kMainColor CGColor];
    self.getCodeBtn.layer.borderWidth = 1;
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    WS(ws);
    [self.getCodeBtn addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
        
        
    }];
    [self.view addSubview:self.getCodeBtn];
//    [self.getCodeBtn startWithSecond:59];
    
    
    self.registBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance, CGRectGetMaxY(self.codeText.frame)+2*kDistance, self.tellText.width, kTextFieldHeight)];
    [self.registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    
    _readPolicyView = [[CWSReadPolicyView alloc]initWithFrame:CGRectMake(self.registBtn.x, self.registBtn.y+self.registBtn.height+20, kSizeOfScreen.width-30, 20)];
    _readPolicyView.delegate = self;
    [self.view addSubview:_readPolicyView];
    
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

-(void)registClick
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
