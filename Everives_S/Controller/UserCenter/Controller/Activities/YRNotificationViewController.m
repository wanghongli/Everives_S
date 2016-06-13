//
//  YRNotificationViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRNotificationViewController.h"
#import "YRActivityTableViewCell.h"
#import "YRActivityModel.h"
@interface YRNotificationViewController (){
    NSArray *_activitymodels;
}
@end

static NSString *cellID = @"YRActivityTableViewCellID";
@implementation YRNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动通知";
    self.clearsSelectionOnViewWillAppear = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"YRActivityTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 150;
    [self getActivities];
    
}

-(void)getActivities{
    [RequestData GET:ACTIVITY_ACTIVITY parameters:nil complete:^(NSDictionary *responseDic) {
        _activitymodels = [YRActivityModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _activitymodels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[YRActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

    }
    [cell setModel:_activitymodels[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerID"];
    if(!header){
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerID"];
        header.contentView.backgroundColor = kCOLOR(250, 250, 250);
    }
    if (section == 0) {
        header.contentView.backgroundColor = [UIColor whiteColor];
    }
    return header;
}

@end
