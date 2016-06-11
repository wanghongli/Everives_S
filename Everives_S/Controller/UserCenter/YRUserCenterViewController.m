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
#import <UIImageView+WebCache.h>
#import "RequestData.h"
#import "REFrostedViewController.h"
#import "YRUserDetailController.h"
#import "YRUserCertificationController.h"
#import "YRCertificationController.h"
@interface YRUserCenterViewController (){
    NSArray *cellNmaes;
    NSArray *cellImgs;
    NSArray *cellClick;
}
@property(nonatomic,strong) UIView *tableHeader;
@property(nonatomic,strong) UILabel *nameL;
@property(nonatomic,strong) UILabel *signL;
@property(nonatomic,strong) UIImageView *avatarImage;
@end

@implementation YRUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = kCOLOR(230, 230, 230);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 20);
    cellNmaes = @[@"我的预约",@"我的钱包",@"我的评价",@"活动通知",@"信息认证"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu_icon"] highImage:[UIImage imageNamed:@"menu_icon"] target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
    line.backgroundColor = kCOLOR(250, 250, 250);
    line.layer.borderColor = kCOLOR(240, 240, 240).CGColor;
    line.layer.borderWidth = 0.8;
    return line;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = KDarkColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.indentationLevel = 2;
        cell.indentationWidth = 10;
    }
    //个人资料
    if (indexPath.section == 0) {
        
        [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:kUSERAVATAR_PLACEHOLDR]];
        self.signL.text = KUserManager.sign.length == 0?@"一句话简单介绍一下自己吧":KUserManager.sign;
        self.nameL.text = KUserManager.name;
        [cell addSubview:self.avatarImage];
        [cell addSubview:self.nameL];
        [cell addSubview:self.signL];
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
        case 4://信息认证
        {
            if(KUserManager.status == 2){
                [self.navigationController pushViewController:
                 [[YRCertificationController alloc] init] animated:YES];
            }else{
                [self.navigationController pushViewController:
                 [[YRUserCertificationController alloc] init] animated:YES];
            }
            
            break;
        }
            
        default:
            break;
    }
}
#pragma maark - Getters
-(UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc] initWithFrame:CGRectMake(105, 18, 150, 30)];
        _nameL.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        _nameL.textColor = KDarkColor;
    }
    return _nameL;
}
-(UILabel *)signL{
    if (!_signL) {
        _signL = [[UILabel alloc] initWithFrame:CGRectMake(105, 47, kScreenWidth-110, 30)];
        _signL.font = kFontOfLetterMedium;
        _signL.textColor = [UIColor lightGrayColor];
    }
    return _signL;
}
-(UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 8, 74, 74)];
        _avatarImage.layer.masksToBounds = YES;
        _avatarImage.layer.cornerRadius = 37;
        _avatarImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _avatarImage.layer.borderWidth = 0.5;
    }
    return _avatarImage;
}
@end
