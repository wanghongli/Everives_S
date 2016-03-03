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

#define kDistance 10
#define kTextFieldHeight 44
@interface YRYJRegistViewController ()

@property (nonatomic, strong) UITextField *tellText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) JKCountDownButton *getCodeBtn;
@property (nonatomic, strong) CWSPublicButton *registBtn;//注册按钮
@end

@implementation YRYJRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";

    
}
- (void)buildUI
{
    //手机号码输入框
    self.tellText = [self setTextFieldWithFrame:CGRectMake(kDistance, kDistance*2+64, kSizeOfScreen.width-2*kDistance, kTextFieldHeight) withPlaceholder:@"请输入您的手机号"];
    [self.view addSubview:self.tellText];
    
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
