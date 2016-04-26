//
//  YRYJNavigationController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/17.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJNavigationController.h"
#import "YRYJMenuViewController.h"
#import "UIBarButtonItem+Item.h"
#import "UIViewController+REFrostedViewController.h"
@interface YRYJNavigationController ()<UINavigationControllerDelegate>

@property (strong, readwrite, nonatomic) YRYJMenuViewController *menuViewController;
@property (nonatomic, strong) id popDelegate;

@end

@implementation YRYJNavigationController
+(void)initialize
{
    //获取当前类下面的UIBbarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    //设置导航按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {//不是跟控制器
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(popToPre) forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    [super pushViewController:viewController animated:YES];
}
- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    //删除系统自带的tabBarButton
    //    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
    //        if (![tabBarButton isKindOfClass:[CZTabBar class]]) {
    //            [tabBarButton removeFromSuperview];
    //        }
    //    }
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {//是根控制器
        self.interactivePopGestureRecognizer.delegate = nil;
    }else//非根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
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
