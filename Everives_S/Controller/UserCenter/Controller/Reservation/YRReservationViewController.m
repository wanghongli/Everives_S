//
//  YRReservationViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationViewController.h"
#import "YRReservationCell.h"
#import "YROrderedPlaceModel.h"
#import "YRAppointmentDetailController.h"
static NSString *cellId = @"YRReservationCellID";
@interface YRReservationViewController (){
    NSArray *_models;
}

@end

@implementation YRReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的预约";
    [self.tableView registerNib:[UINib nibWithNibName:@"YRReservationCell" bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.rowHeight = 108;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self getData];
}

-(void)getData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestData GET:STUDENT_ORDER parameters:@{@"page":@"0"} complete:^(NSDictionary *responseDic) {
        _models = [YROrderedPlaceModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell configCellWithModel:_models[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRAppointmentDetailController *detailVC = [[YRAppointmentDetailController alloc]initWithNibName:@"YRAppointmentDetailController" bundle:nil];
    detailVC.title = @"预约详情";
    detailVC.orderId = [_models[indexPath.row] id];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
