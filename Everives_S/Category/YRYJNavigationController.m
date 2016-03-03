//
//  YRYJNavigationController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/17.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJNavigationController.h"
#import "YRYJMenuViewController.h"
#import "UIViewController+REFrostedViewController.h"
@interface YRYJNavigationController ()

@property (strong, readwrite, nonatomic) YRYJMenuViewController *menuViewController;


@end

@implementation YRYJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}


@end
