//
//  YRPersonalDataController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPersonalDataController.h"

@interface YRPersonalDataController ()

@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YRPersonalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.baseView.frame.size.height);
    [self.scrollView addSubview:self.baseView];
    
    if (self.baseView.frame.size.height>self.scrollView.size.height) {
        self.scrollView.contentSize = CGSizeMake(0, self.baseView.frame.size.height);
    }else{
        self.scrollView.contentSize = CGSizeMake(0, self.scrollView.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
