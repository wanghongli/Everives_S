//
//  YRAppointmentDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAppointmentDetailController.h"
#import "YRAppointmentHeadView.h"
#import "YRTeacherDetailController.h"
#import "YRLearnOrderDetail.h"
#import "YRLearnOrderDetailInfo.h"
#import "YRTeacherMakeCommentController.h"
@interface YRAppointmentDetailController () <YRAppointmentHeadViewDelegate>
{
    NSArray *_titleArray;
    NSArray *_menuArray;
    NSMutableArray *_totalMenu;
}
@property (nonatomic, strong) YRAppointmentHeadView *headView;//头不视图
@property (nonatomic, strong) YRLearnOrderDetail *orderDetail;//详情模型
@property (nonatomic, strong) UIButton *startBtn;
@end

@implementation YRAppointmentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"预约时间",@"学车时段",@"训练场地准",@"预约费用"];
    _menuArray = @[@"2016年3月4日 星期五",@"14:00-16:00&17:00-18:00",@"玉祥驾校南山区",@"￥450"];
    _headView = [[YRAppointmentHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    _headView.delegate = self;
    self.tableView.tableHeaderView = self.headView;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, footView.height-40, kScreenWidth-40, 40)];
    [self.startBtn setTitle:@"发消息" forState:UIControlStateNormal];
    [self.startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.startBtn.backgroundColor = kCOLOR(50, 51, 52);
    [self.startBtn addTarget:self action:@selector(sartClick:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn.layer.masksToBounds = YES;
    self.startBtn.layer.cornerRadius = self.startBtn.height/2;
    [footView addSubview:self.startBtn];
    self.tableView.tableFooterView = footView;
    [self getData];
}
-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:GET_WINDOW];
    [RequestData GET:[NSString stringWithFormat:@"/order/order/%@",self.orderId] parameters:@{} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
        self.orderDetail = [YRLearnOrderDetail mj_objectWithKeyValues:responseDic];
        self.headView.orderDetail = self.orderDetail;
        _totalMenu = [NSMutableArray array];
        for (int i = 0 ; i<self.orderDetail.info.count; i++) {
            YRLearnOrderDetailInfo *detailInfo = self.orderDetail.info[i];
            NSString *orderTime = [YRPublicMethod getDateAndWeekWith:detailInfo.date];;
            NSString *string = [YRPublicMethod getDetailLearnTimeWith:detailInfo.time];
            NSString *price = [NSString stringWithFormat:@"￥%ld",detailInfo.price];
            _menuArray = @[orderTime,string,detailInfo.place,price];
            [_totalMenu addObject:_menuArray];
        }
        
        [self setStarBtnTitle:[YRPublicMethod getOrderStatusWith:self.orderDetail.status]];
        
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
    }];
}
-(void)setStarBtnTitle:(NSString *)titleString
{
    if ([titleString isEqualToString:@"未支付"]) {
        [self.startBtn setTitle:@"去支付" forState:UIControlStateNormal];
    }else if ([titleString isEqualToString:@"已完成,等待评价"]){
        [self.startBtn setTitle:@"去评价" forState:UIControlStateNormal];
    }else{
        [self.startBtn setTitle:@"发消息" forState:UIControlStateNormal];
    }
}
-(void)sartClick:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"未支付"]) {//去支付
        
    }else if ([sender.titleLabel.text isEqualToString:@"去评价"]){//去评价
        YRTeacherMakeCommentController *makeCommentVC = [[YRTeacherMakeCommentController alloc]init];
        makeCommentVC.orderID = [NSString stringWithFormat:@"%ld",self.orderDetail.id];
        [self.navigationController pushViewController:makeCommentVC animated:YES];
    }else{//发送消息
    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderDetail.info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    NSArray *array = _totalMenu[indexPath.section];
    cell.detailTextLabel.text = array[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.orderDetail.info.count-1) {
        return 2;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)appointmentHeadViewClick
{
    YRTeacherDetailController *tdc = [[YRTeacherDetailController alloc]init];
    [self.navigationController pushViewController:tdc animated:YES];
}
@end
