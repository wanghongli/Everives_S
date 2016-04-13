//
//  YROrderConfirmViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YROrderConfirmViewController.h"
#import "YRTeacherDetailObj.h"
#import "YRStarsView.h"
#import "YRReservationDateVC.h"
#import "YRReservationChoosePlaceVC.h"
static NSString *cellID = @"cellID";
static BOOL hasCommit = NO;
@interface YROrderConfirmViewController ()<UIAlertViewDelegate>{
    NSArray *_times;
}
@property(nonatomic,strong) UIView *coachView;
@property(nonatomic,strong) UIButton *commitFooterBtn;
@property(nonatomic,strong) UIView *footerView;
@property(nonatomic,strong) NSString *orderID;
@end

@implementation YROrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    _times = @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"];
    self.tableView.tableFooterView = self.footerView;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    hasCommit = NO;
}
-(void)commitBtnClick:(UIBarButtonItem*)sender{
    if (hasCommit) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"订单已经提交过了，请勿重复提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    //提交订单
    [RequestData POST:STUDENT_ORDER parameters:_parameters complete:^(NSDictionary *responseDic) {
        hasCommit = YES;
        _orderID = responseDic[@"id"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认支付" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"支付", nil];
        [alertView show];
    } failed:^(NSError *error) {

    }];
}
-(void)returnToCoachDetail{
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[YRReservationDateVC class]]||[obj isKindOfClass:[YRReservationChoosePlaceVC class]]) {
            [allViewControllers removeObjectIdenticalTo: obj];
        }
    }];
    self.navigationController.viewControllers = allViewControllers;
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableView
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 70;
    }
    switch (indexPath.row) {
        case 0:
        case 1:
            return 70;
        case 2:
            return 50+30*_DateTimeArray.count;
        case 3:
            return 100;
        default:
            return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?:4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?10:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 40, 30)];
    switch (indexPath.section*4+indexPath.row) {
        case 0:
        {
            titleLab.text = @"驾校";
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 100, 30)];
            contentLab.text = @"玉祥驾校";
            [cell.contentView addSubview:titleLab];
            [cell.contentView addSubview:contentLab];
            return  cell;
        }
        case 1:
        {
            titleLab.text = @"项目";
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 70, 30)];
            contentLab.text = _coachModel.kind?@"科目三":@"科目二";
            contentLab.textAlignment = NSTextAlignmentCenter;
            contentLab.backgroundColor = [UIColor colorWithRed:43/255.0 green:162/255.0 blue:238/255.0 alpha:1.0];
            contentLab.layer.cornerRadius = 15;
            contentLab.layer.masksToBounds = YES;
            [cell.contentView addSubview:titleLab];
            [cell.contentView addSubview:contentLab];
            return  cell;
        }
        case 2:
        {
            titleLab.text = @"时段";
            [_DateTimeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20+30*idx, kScreenWidth -60, 30)];
                contentLab.text = [NSString stringWithFormat:@"%@ %@ %@",obj[@"date"],[NSString getTheDayInWeek:obj[@"date"]],_times[[obj[@"time"] integerValue]-1]];
                [cell.contentView addSubview:contentLab];
            }];
            [cell.contentView addSubview:titleLab];
            return  cell;
        }
        case 3:
        {
            titleLab.text = @"教练";
            [cell.contentView addSubview:self.coachView];
            [cell.contentView addSubview:titleLab];
            return  cell;
        }
        case 4:
        {
            titleLab.text = @"合计";
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 100, 30)];
            contentLab.text = [NSString stringWithFormat:@"￥ %li",_totalPrice];
            contentLab.textColor = [UIColor redColor];
            [cell.contentView addSubview:titleLab];
            [cell.contentView addSubview:contentLab];
            return  cell;
        }
            
        default:
            return cell;
    }
}
#pragma mark - UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //确认支付
    if (buttonIndex == 1) {
        [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_PAY,_orderID] parameters:nil complete:^(NSDictionary *responseDic) {
            
        } failed:^(NSError *error) {
            
        }];
        UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"支付成功" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
        successAlertView.tag = 2333;
        [successAlertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 2333){
        [self returnToCoachDetail];
    }
}
#pragma mark - Getters
-(UIView *)coachView{
    if (!_coachView) {
        _coachView.backgroundColor = [UIColor colorWithWhite:0.748 alpha:1.000];
        _coachView = [[UIView alloc] initWithFrame:CGRectMake(90, 10, kScreenWidth - 60, 80)];
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 70, 70)];
        avatar.layer.cornerRadius = 35;
        [avatar sd_setImageWithURL:[NSURL URLWithString:_coachModel.avatar]];
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, kScreenWidth - 200, 30)];
        name.text = _coachModel.name;
        YRStarsView * stars = [[YRStarsView alloc] initWithFrame:CGRectMake(110, 35, 120, 30) score:[_coachModel.grade integerValue]  starWidth:20 intervel:3 needLabel:YES];
        [_coachView addSubview:avatar];
        [_coachView addSubview:name];
        [_coachView addSubview:stars];
        
    }
    return _coachView;
}

-(UIButton *)commitFooterBtn{
    if (!_commitFooterBtn) {
        _commitFooterBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, kScreenWidth-60, 30)];
        [_commitFooterBtn setTitle:@"提交订单" forState:UIControlStateNormal];
        [_commitFooterBtn setTitleColor:kTextBlackColor forState:UIControlStateNormal];
        [_commitFooterBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _commitFooterBtn.layer.cornerRadius = 20;
        _commitFooterBtn.layer.borderColor = kTextlightGrayColor.CGColor;
        _commitFooterBtn.layer.borderWidth = 0.5;
        
    }
    return _commitFooterBtn;
}
-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        [_footerView addSubview:self.commitFooterBtn];
    }
    return _footerView;
}
@end
