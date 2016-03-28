//
//  YRDriveLawDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRDriveLawDetailController.h"

@interface YRDriveLawDetailController ()

@end

@implementation YRDriveLawDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"法规详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
}
-(void)buildUI
{
    //显示答案
    UIBarButtonItem *addPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_Share"] style:UIBarButtonItemStyleBordered target:self action:@selector(shareClick)];
    //收藏
    UIBarButtonItem *searchPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_CollectionHollow"] style:UIBarButtonItemStyleBordered target:self action:@selector(collectionClick)];
    self.navigationItem.rightBarButtonItems = @[addPlaceBtn,searchPlaceBtn];
}
#pragma mark - 分享
-(void)shareClick
{
    
}
#pragma mark - 收藏
-(void)collectionClick
{
    
}

@end
