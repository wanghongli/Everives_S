//
//  YRReservationViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationViewController.h"
#import "YRReservationCell.h"
#import "YRReservationDetailVC.h"
#import "YROrderedPlaceModel.h"
static NSString *cellId = @"YRReservationCellID";
@interface YRReservationViewController (){
    NSArray *_models;
}

@end

@implementation YRReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"YRReservationCell" bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.rowHeight = 108;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self getData];
}

-(void)getData{
    [RequestData GET:STUDENT_ORDER parameters:@{@"page":@"0"} complete:^(NSDictionary *responseDic) {
        _models = [YROrderedPlaceModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } failed:^(NSError *error) {
        
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
    YRReservationDetailVC *detailVC = [[YRReservationDetailVC alloc] init];
    detailVC.orderID = [_models[indexPath.row] id];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
