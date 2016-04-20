//
//  StudentDataSource.m
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "StudentDataSource.h"
#import "YRStudentTableCell.h"
#import "YRUserStatus.h"
#import <MJRefresh.h>
static NSString * studentCellID = @"YRStudentTableCellID";
@interface StudentDataSource ()
@property(nonatomic,assign)NSInteger page;
@end
@implementation StudentDataSource
-(instancetype)init{
    if (self = [super init]) {
        _stuArray = @[].mutableCopy;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _stuArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_stuArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRStudentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:studentCellID];
    if (!cell) {
        cell = [[YRStudentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studentCellID];
    }
    cell.model =_stuArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)getData{
    _page = 0;
    NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0"};
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_NEARBY parameters:parameters complete:^(NSDictionary *responseDic) {
        NSArray *stuArr = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        if (stuArr.count<10) {
            [self.table.mj_footer endRefreshingWithNoMoreData];
        }
        [_stuArray removeAllObjects];
        [_stuArray addObject:stuArr];
        [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
-(void)loadMoreData{
    _page++;
    NSDictionary *parameters = @{@"page":[NSNumber numberWithInteger:_page],@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0"};
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_NEARBY parameters:parameters complete:^(NSDictionary *responseDic) {
        NSArray *models = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        if (models.count == 0) {
            [MBProgressHUD hideHUDForView:self.table animated:YES];
            [self.table.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [_stuArray addObject:models];
        [self.table insertSections:[NSIndexSet indexSetWithIndex:_page] withRowAnimation:UITableViewRowAnimationNone];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
@end
