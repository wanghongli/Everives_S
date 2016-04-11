//
//  YRReservationDetailVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationDetailVC.h"
#import "YRChatViewController.h"
#import "YROrderedPlaceDetailModel.h"
#import <UIImageView+WebCache.h>
#import "YROrderItemCell.h"

static NSString *cellID = @"cellID";
@interface YRReservationDetailVC (){
    NSArray *_statusArr;
    YROrderedPlaceDetailModel *_model;
}
@property(nonatomic,strong) UIView *myTableFooter;
@property(nonatomic,strong) UIView *myTableHeader;
@end

@implementation YRReservationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusArr = @[@"未支付" ,@"已支付",@"等待同伴一起拼",@"已支付",@"等待去练车", @"待评价" ,@"已评价" ,@"已取消"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YROrderItemCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 90;
    
    [self getData];
}
-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@/%@",STUDENT_ORDER,_orderID] parameters:nil complete:^(NSDictionary *responseDic) {
        _model = [YROrderedPlaceDetailModel mj_objectWithKeyValues:responseDic];
        self.tableView.tableHeaderView = self.myTableHeader;
        self.tableView.tableFooterView = self.myTableFooter;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - uitableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.info.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YROrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell configCellWithModel:_model.info[indexPath.row]];
    return cell;
}
-(UIView *)myTableHeader{
    if (!_myTableHeader) {
        _myTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-40, 30, 80, 80)];
        [avatar sd_setImageWithURL:[NSURL URLWithString:_model.avatar]];
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 115, 100, 20)];
        name.text = _model.tname;
        name.textAlignment = NSTextAlignmentCenter;
        UILabel *state = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, 140, 100, 20)];
        state.text = _statusArr[[_model.status integerValue]];
        state.textAlignment = NSTextAlignmentCenter;
        [_myTableHeader addSubview:avatar];
        [_myTableHeader addSubview:name];
        [_myTableHeader addSubview:state];
        
    }
    return _myTableHeader;
}
-(UIView *)myTableFooter{
    if (!_myTableFooter) {
        _myTableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 30, kScreenWidth-100, 50)];
        [btn setTitle:_statusArr[[_model.status integerValue]] forState:UIControlStateNormal];
        btn.titleLabel.font = kFontOfLetterMedium;
        btn.backgroundColor = [UIColor colorWithWhite:0.181 alpha:1.000];
        btn.layer.cornerRadius = 25;
        [btn addTarget:self action:@selector(footerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_myTableFooter addSubview:btn];
    }
    return _myTableFooter;
}

-(void)footerBtnClick:(UIButton*)sender{
    
}
@end
