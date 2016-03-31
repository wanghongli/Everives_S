//
//  UIViewController+YRCommonController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "UIViewController+YRCommonController.h"
#import "YRYJNavigationController.h"
@implementation UIViewController (YRCommonController)
- (void)goToLoginVC
{
    [MBProgressHUD showError:@"请登陆" toView:GET_WINDOW];
    YRLoginViewController *loginVC = [[YRLoginViewController alloc]init];
    loginVC.title = @"登陆";
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}
@end
