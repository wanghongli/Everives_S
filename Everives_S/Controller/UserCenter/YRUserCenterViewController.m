//
//  YRUserCenterViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserCenterViewController.h"
#import "YRReservationViewController.h"
#import "YRMyWalletViewController.h"
#import "YRMyCommentsTableViewController.h"
#import "YRNotificationViewController.h"
#import "YRCertificationViewController.h"
#import <UIImageView+WebCache.h>
#import "RequestData.h"
#import "REFrostedViewController.h"
#import "YRUserDetailController.h"
#import "YRCertificationController.h"
@interface YRUserCenterViewController (){
    NSArray *cellNmaes;
    NSArray *cellImgs;
    NSArray *cellClick;
}
@property(nonatomic,strong) UIView *tableHeader;
@end

@implementation YRUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.frostedViewController.panGestureEnabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    cellNmaes = @[@"我的预约",@"我的钱包",@"我的评价",@"活动通知",@"信息认证"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu)];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    self.frostedViewController.panGestureEnabled = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.frostedViewController.panGestureEnabled = NO;
}
- (void)backBtnClick:(UIBarButtonItem*)sender{
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1;
        }
        case 1:{
            return 3;
        }
        case 2:{
            return 2;
        }
            
        default:
            return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?5:0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section?54:90;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithWhite:0.946 alpha:1.000];
    return line;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.indentationLevel = 1.5;
    cell.indentationWidth = 10;
    //个人资料
    if (indexPath.section == 0) {
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(18, 8, 74, 74)];
        avatar.layer.masksToBounds = YES;
        avatar.layer.cornerRadius = 37;
        avatar.layer.borderColor = [UIColor lightGrayColor].CGColor;
        avatar.layer.borderWidth = 0.5;
        [avatar sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar]];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(105, 12, 150, 30)];
        name.text = KUserManager.name;
        name.font = [UIFont systemFontOfSize:16];
        
        UILabel *sign = [[UILabel alloc] initWithFrame:CGRectMake(105, 50, kScreenWidth-110, 30)];
        sign.text = KUserManager.sign;
        sign.font = [UIFont systemFontOfSize:14];
        sign.textColor = [UIColor lightGrayColor];
        
        [cell addSubview:avatar];
        [cell addSubview:name];
        [cell addSubview:sign];
        return cell;
    }
    cell.textLabel.text = cellNmaes[(indexPath.section-1)*3+indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YRUserDetailController *detail = [[YRUserDetailController alloc] init];
        [self.navigationController pushViewController:detail animated:YES];
        return;
    }
    switch ((indexPath.section-1)*3+indexPath.row) {
        case 0:
        {
           [self.navigationController pushViewController: [[YRReservationViewController alloc] init] animated:YES] ;
           break;
        }
        case 1:
        {
            [self.navigationController pushViewController:
             [[YRMyWalletViewController alloc] init] animated:YES] ;
            break;
        }
        case 2:
        {
            [self.navigationController pushViewController:
             [[YRMyCommentsTableViewController alloc] init] animated:YES] ;
            break;
        }
        case 3:
        {
            [self.navigationController pushViewController:
             [[YRNotificationViewController alloc] init] animated:YES] ;
            break;
        }
        case 4:
        {
            [self.navigationController pushViewController:
             [[YRCertificationController alloc] init] animated:YES] ;
            break;
        }
            
        default:
            break;
    }
}
@end
