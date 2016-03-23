//
//  YRLearnOrderController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnOrderController.h"
#import "YRLearnPracticeController.h"
@interface YRLearnOrderController ()

@end

@implementation YRLearnOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"顺序练习";
    
    [self buildUI];
}
-(void)buildUI
{
    self.baseView.frame = CGRectMake(0, 64, kScreenWidth, self.baseView.height);
    [self.view addSubview:self.baseView];
    
    self.goOnBtn.layer.masksToBounds = YES;
    self.goOnBtn.layer.cornerRadius = self.goOnBtn.height/2;
    
    self.replyBtn.layer.masksToBounds = YES;
    self.replyBtn.layer.cornerRadius = self.replyBtn.height/2;
    self.replyBtn.layer.borderWidth = 1;
    self.replyBtn.layer.borderColor = kCOLOR(51, 51, 51).CGColor;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnClick:(UIButton *)sender {
    YRLearnPracticeController *practiceVC = [[YRLearnPracticeController alloc]init];
    practiceVC.title = @"顺序练习";
    if (sender.tag == 20) {//继续答题
        practiceVC.currentID = 4;
    }else{//重新答题
        practiceVC.currentID = 1;
    }
    practiceVC.menuTag = 1;
    [self.navigationController pushViewController:practiceVC animated:YES];
}
@end
