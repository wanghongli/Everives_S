//
//  YRYJMenuViewController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/17.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJMenuViewController.h"
#import "YRYJNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "YRYJLearnToDriveController.h"
#import "UIView+SDAutoLayout.h"
#import "YRLoginViewController.h"
#import "YRUserCenterViewController.h"
#import "YRFriendCircleController.h"
#import "YRFriendViewController.h"
#import "YRNearViewController.h"
#import "YRMenuHeadView.h"
#import "YRMenuMessageController.h"
#import "YRSettingController.h"
@interface YRYJMenuViewController ()<UIAlertViewDelegate,YRMenuHeadViewDelegate>
@property (nonatomic, strong) YRMenuHeadView *headView;
@end

@implementation YRYJMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    _headView = [[YRMenuHeadView alloc]initWithFrame:CGRectMake(0, 0, 0, 130.0f)];
    _headView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _headView.image = [UIImage imageNamed:@"Drawer_Background"];
    _headView.delegate = self;
    self.tableView.tableHeaderView = _headView;
    self.tableView.tableFooterView = [[UIView alloc]init];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (KUserManager.id) {
        _headView.loginBool = YES;
    }else{
        _headView.loginBool = NO;
    }
}
-(void)userClick:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 2)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 ) {
        YRYJLearnToDriveController *homeViewController = [[YRYJLearnToDriveController alloc] init];
        YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
    } else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            if (!KUserManager.id) {//登陆
                [self menuHeadViewLoginClick];
                return;
            }
            YRFriendViewController *friendViewController = [[YRFriendViewController alloc] init];
            YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:friendViewController];
            self.frostedViewController.contentViewController = navigationController;
        }else if (indexPath.row == 1) {
            if (!KUserManager.id) {//登陆
                [self menuHeadViewLoginClick];
                return;
            }
            YRFriendCircleController *secondViewController = [[YRFriendCircleController alloc] init];
            secondViewController.title = @"驾友圈";
            YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:secondViewController];
            self.frostedViewController.contentViewController = navigationController;
        }else if (indexPath.row == 2) {
            YRNearViewController *nearViewController = [[YRNearViewController alloc] init];
            YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:nearViewController];
            self.frostedViewController.contentViewController = navigationController;
        }else if (indexPath.row == 3) {
            UIViewController *secondViewController = [[YRUserCenterViewController alloc] init];
            YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:secondViewController];
            self.frostedViewController.contentViewController = navigationController;
        }
        
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            YRSettingController *secondViewController = [[YRSettingController alloc] init];
            YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:secondViewController];
            self.frostedViewController.contentViewController = navigationController;
        }else if (indexPath.row == 1) {//注销
            if (KUserManager.id) {
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注销", nil] show];
                return;
            }else{
                [MBProgressHUD showError:@"您还未登陆，请先登录？" toView:GET_WINDOW];
            }
        }
    }
    
    [self.frostedViewController hideMenuViewController];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        KUserManager.id = 0;
        YRYJLearnToDriveController *homeViewController = [[YRYJLearnToDriveController alloc] init];
        YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:homeViewController];
        [self.frostedViewController hideMenuViewController];

        self.frostedViewController.contentViewController = navigationController;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginCount"];
        _headView.loginBool = NO;

        [[RCIM sharedRCIM] disconnect:NO];
        
    }
}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return 1;
    }else if (sectionIndex ==1){
        return 4;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section == 0) {
        NSArray *titles = @[@"学车"];
        cell.textLabel.text = titles[indexPath.row];
    }else if (indexPath.section == 1) {
        NSArray *titles = @[@"驾友", @"驾友圈", @"附近",@"个人"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        NSArray *titles = @[@"设置", @"注销"];
        cell.textLabel.text = titles[indexPath.row];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
#pragma mark - 消息中心
-(void)menuHeadViewNotiClick
{
    YRMenuMessageController *messageVC = [[YRMenuMessageController alloc]init];
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:messageVC];
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}
#pragma mark - 登陆
-(void)menuHeadViewLoginClick
{
    [MBProgressHUD showError:@"请登陆" toView:GET_WINDOW];
    YRLoginViewController *loginVC = [[YRLoginViewController alloc]init];
    loginVC.title = @"登陆";
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
