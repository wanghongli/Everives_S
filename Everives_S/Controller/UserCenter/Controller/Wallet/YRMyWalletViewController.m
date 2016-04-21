//
//  YRMyWalletVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyWalletViewController.h"
#import "YRStudentMoneyDetailVC.h"


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
    _recharge.layer.borderWidth = 0.5;
    _recharge.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _recharge.layer.cornerRadius = 10;
    _withDrawal.layer.borderWidth = 0.5;
    _withDrawal.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _withDrawal.layer.cornerRadius = 10;
    [self getMoney];

}

-(void)getMoney{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestData GET:STUDENT_MONEY parameters:nil complete:^(NSDictionary *responseDic) {
        KUserManager.money = responseDic[@"money"];
        KUserManager.frozenMoney = responseDic[@"frozenMoney"];
        _money.text = [NSString stringWithFormat:@"%li",[KUserManager.money integerValue]];
        _frozenMoney.text = [NSString stringWithFormat:@"%li",[KUserManager.frozenMoney integerValue]];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
- (IBAction)moneyDetailCilck:(UIButton *)sender {
    [self.navigationController pushViewController:[[YRStudentMoneyDetailVC alloc] init] animated:YES];
}
- (IBAction)rechageBtnClick:(UIButton *)sender {
}
- (IBAction)withDrawalBtnClick:(UIButton *)sender {
}



@end
