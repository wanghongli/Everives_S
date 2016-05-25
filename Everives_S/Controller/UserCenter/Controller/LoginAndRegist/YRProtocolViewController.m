//
//  YRProtocolViewController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/5/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRProtocolViewController.h"

@interface YRProtocolViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation YRProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    self.textView.editable = NO;
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
