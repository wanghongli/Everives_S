//
//  YRFriendCircleController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFriendCircleController.h"
#import "YRAddWeiboController.h"
@interface YRFriendCircleController ()

@end

@implementation YRFriendCircleController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"驾友圈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addWeiboClick:)];
    
}

-(void)addWeiboClick:(UIBarButtonItem *)sender
{
    YRAddWeiboController *addWeiboVC = [[YRAddWeiboController alloc]init];
    [self.navigationController pushViewController:addWeiboVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
