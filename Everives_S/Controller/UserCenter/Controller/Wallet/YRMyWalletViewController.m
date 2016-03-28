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
    
    _money.text = KUserManager.money;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)moneyDetailCilck:(UIButton *)sender {
    [self.navigationController pushViewController:[[YRStudentMoneyDetailVC alloc] init] animated:YES];
}
- (IBAction)rechageBtnClick:(UIButton *)sender {
}
- (IBAction)withDrawalBtnClick:(UIButton *)sender {
}



@end
