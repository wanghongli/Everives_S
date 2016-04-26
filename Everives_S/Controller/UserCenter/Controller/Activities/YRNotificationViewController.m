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
    self.tableView.rowHeight = 100;
    [self getActivities];
    
}

-(void)getActivities{
    [RequestData GET:ACTIVITY_ACTIVITY parameters:nil complete:^(NSDictionary *responseDic) {
        _activitymodels = [YRActivityModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activitymodels.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[YRActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setModel:_activitymodels[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
