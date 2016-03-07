//
//  YRAddWeiboController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAddWeiboController.h"
#import "JKImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface YRAddWeiboController ()<JKImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>

@end

@implementation YRAddWeiboController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
