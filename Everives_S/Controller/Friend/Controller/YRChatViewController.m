//
//  YRChatViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRChatViewController.h"
#import "YRUserDetailController.h"
@interface YRChatViewController ()

@end

@implementation YRChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
