//
//  YRChatViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRChatViewController.h"
#import "YRUserDetailController.h"
#import "YRContactVC.h"
@interface YRChatViewController ()

@end

@implementation YRChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //从controller栈中移除一些controller
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[YRContactVC class]]) {
            [allViewControllers removeObjectIdenticalTo: obj];
        }
    }];
    self.navigationController.viewControllers = allViewControllers;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didTapCellPortrait:(NSString *)userId{
    YRUserDetailController *userDetailVC = [[YRUserDetailController alloc] init];
    NSString  *idStr = [NSString string];
    if ([userId hasPrefix:@"stu"]) {
        idStr = [userId substringFromIndex:3];
    }
    userDetailVC.userID = idStr;
    [self.navigationController pushViewController:userDetailVC animated:YES];
}

@end
