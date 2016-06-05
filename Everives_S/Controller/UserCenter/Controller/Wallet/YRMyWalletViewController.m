//
//  YRMyWalletVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyWalletViewController.h"
#import "YRStudentMoneyDetailVC.h"
#import "YRRechargeViewController.h"
#import "YRWithDrawalViewController.h"

@interface YRMyWalletViewController ()
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UILabel *frozenMoney;
@property (weak, nonatomic) IBOutlet UIButton *recharge;
@property (weak, nonatomic) IBOutlet UIButton *withDrawal;

@property (weak, nonatomic) IBOutlet UIButton *detail;

@end

@implementation YRMyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
    _recharge.layer.borderWidth = 1;
    _recharge.layer.borderColor = kCOLOR(166, 167, 168).CGColor;
    _recharge.layer.cornerRadius = 22.5;
    _withDrawal.layer.borderWidth = 1;
    _withDrawal.layer.borderColor = kCOLOR(166, 167, 168).CGColor;
    _withDrawal.layer.cornerRadius = 22.5;
    [self getMoney];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)getMoney{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestData GET:STUDENT_MONEY parameters:nil complete:^(NSDictionary *responseDic) {
        KUserManager.money = responseDic[@"money"];
        KUserManager.frozenMoney = responseDic[@"frozenMoney"];
        _money.text = [NSString stringWithFormat:@"%li",[KUserManager.money integerValue]];
        _frozenMoney.text = [NSString stringWithFormat:@"%li",[KUserManager.frozenMoney integerValue]];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (IBAction)moneyDetailCilck:(UIButton *)sender {
    [self.navigationController pushViewController:[[YRStudentMoneyDetailVC alloc] init] animated:YES];
}
- (IBAction)rechageBtnClick:(UIButton *)sender {
    YRRechargeViewController *recharge = [[YRRechargeViewController alloc] init];
    [self.navigationController pushViewController:recharge animated:YES];
}
- (IBAction)withDrawalBtnClick:(UIButton *)sender {
    YRWithDrawalViewController *drewal = [[YRWithDrawalViewController alloc]init];
    [self.navigationController pushViewController:drewal animated:YES];
}



@end
