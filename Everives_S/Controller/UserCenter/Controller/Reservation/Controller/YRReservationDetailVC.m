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

@end

@implementation YRReservationDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _statusArr = @[@"未支付" ,@"已支付",@"等待同伴一起拼",@"已支付",@"等待去练车", @"待评价" ,@"已评价" ,@"已取消"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"YROrderItemCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 90;
    [self getData];
}
-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@/%@",STUDENT_ORDER,_orderID] parameters:nil complete:^(NSDictionary *responseDic) {
        _model = [YROrderedPlaceDetailModel mj_objectWithKeyValues:responseDic];
        [self.tableView reloadData];
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
@end
