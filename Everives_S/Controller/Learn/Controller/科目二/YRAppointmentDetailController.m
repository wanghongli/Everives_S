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
@interface YRAppointmentDetailController () <YRAppointmentHeadViewDelegate>
{
    NSArray *_titleArray;
    NSArray *_menuArray;
    NSMutableArray *_totalMenu;
}
@property (nonatomic, strong) YRAppointmentHeadView *headView;//头不视图
@property (nonatomic, strong) YRLearnOrderDetail *orderDetail;//详情模型
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
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, footView.height-40, kScreenWidth-40, 40)];
    [startBtn setTitle:@"发消息" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.backgroundColor = kCOLOR(50, 51, 52);
    [startBtn addTarget:self action:@selector(sartClick:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = startBtn.height/2;
    [footView addSubview:startBtn];
    self.tableView.tableFooterView = footView;
    [self getData];
}
-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:GET_WINDOW];
    [RequestData GET:[NSString stringWithFormat:@"/order/order/%@",_teacherOrder.id] parameters:@{} complete:^(NSDictionary *responseDic) {
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
        
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
    }];
}
-(void)sartClick:(UIButton *)sender
{
    //    YRLearnPracticeController *learnVC = [[YRLearnPracticeController alloc]init];
    //    learnVC.title = @"模拟考试";
    //    learnVC.currentID = 1;
    //    learnVC.menuTag = 0;
    //    [self.navigationController pushViewController:learnVC animated:YES];
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
