//
//  YRFeedBackController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFeedBackController.h"

@interface YRFeedBackController ()

@end

@implementation YRFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户反馈";
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets =NO;
    }
    self.sendBtn.layer.masksToBounds = YES;
    self.sendBtn.layer.cornerRadius = self.sendBtn.height/2;
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendClick:(UIButton *)sender {
    if (!self.textView.text.length) {
        [MBProgressHUD showError:@"内容不能为空!!!!" toView:self.view];
        return;
    }
    [RequestData POST:@"/account/Feedback" parameters:@{@"content":self.textView.text} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        [MBProgressHUD showSuccess:@"提交成功！感谢您的反馈^_^" toView:self.view];
    } failed:^(NSError *error) {
        
    }];
}
@end
