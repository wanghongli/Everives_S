//
//  YRCoachDataSource.m
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "CoachDataSource.h"
#import "YRCoachTableCell.h"
#import "YRCoachModel.h"
#import <MJRefresh.h>
static NSString * coachCellID = @"YRCoachTableCellID";
@interface CoachDataSource ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableDictionary *parameters;
@end
@implementation CoachDataSource

-(instancetype)init{
    if (self = [super init]) {
        _coachArray = @[].mutableCopy;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _coachArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_coachArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRCoachTableCell *cell = [tableView dequeueReusableCellWithIdentifier:coachCellID];
    if (!cell) {
        cell = [[YRCoachTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coachCellID];
    }
    cell.model = _coachArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)getDataWithParameters:(NSDictionary *)parameters{
    _page = 0;
    _parameters = parameters.mutableCopy;
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_NEARTEACHER parameters:parameters complete:^(NSDictionary *responseDic) {
        NSArray *coaches = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
        if (coaches.count<10) {
            [self.table.mj_footer endRefreshingWithNoMoreData];
        }
        [_coachArray removeAllObjects];
        [_coachArray addObject:coaches];
        [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
-(void)loadMoreData{
    _page++;
    _parameters[@"page"] = [NSNumber numberWithInteger:_page];
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_NEARTEACHER parameters:_parameters complete:^(NSDictionary *responseDic) {
        NSArray *places = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
        if (places.count == 0) {
            [MBProgressHUD hideHUDForView:self.table animated:YES];
            [self.table.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [_coachArray addObject:places];
        [self.table insertSections:[NSIndexSet indexSetWithIndex:_page] withRowAnimation:UITableViewRowAnimationNone];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
@end
