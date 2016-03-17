//
//  YRMyWalletVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyWalletViewController.h"

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
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
