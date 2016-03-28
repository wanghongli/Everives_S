//
//  YRStudentMoneyDetailVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRStudentMoneyDetailVC.h"
#import "YRMoneyDetailModel.h"
#import "RequestData.h"
#import "YRMoneyDetailCell.h"
@interface YRStudentMoneyDetailVC (){
    NSArray *_models;
}

@end

@implementation YRStudentMoneyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 50;
    [self getData];
}

-(void)getData{
    [RequestData GET:STUDENT_MONEY parameters:@{@"page":@"0"} complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        _models = [YRMoneyDetailModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
static NSString *cellID = @"cellID";
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRMoneyDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YRMoneyDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configCellWithContent:[_models[indexPath.row] content] time:[_models[indexPath.row] time]];
    return cell;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}



@end