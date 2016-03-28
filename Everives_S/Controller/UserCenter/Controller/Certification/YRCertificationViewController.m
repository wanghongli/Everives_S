//
//  YRCertificationViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCertificationViewController.h"
#import "RequestData.h"
#import "MBProgressHUD+Add.h"

@interface YRCertificationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberLabel;

@end

@implementation YRCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)identifyBtnclick:(UIButton *)sender {
    if (!_numberLabel.text) {
        return;
    }
    if (!_numberLabel.text&&_numberLabel.text.length!=18) {
        return;
    }
    [RequestData POST:STUDENT_IDENTIFY parameters:@{@"realname":_nameLabel.text,@"peopleId":_numberLabel} complete:^(NSDictionary *responseDic) {
        [MBProgressHUD showSuccess:@"认证信息已发送" toView:self.view];
    } failed:^(NSError *error) {
        
    }];

}


@end
