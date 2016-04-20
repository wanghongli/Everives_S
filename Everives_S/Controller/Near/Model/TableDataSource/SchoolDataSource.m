//
//  SchoolDataSource.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "SchoolDataSource.h"
#import "YRSchoolTableCell.h"
#import "RequestData.h"
#import <MJExtension.h>
#import "YRSchoolModel.h"
#import <MJRefresh.h>
static NSString * schoolCellID = @"YRSchoolTableCellID";
@interface SchoolDataSource ()
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableDictionary *parameters;
@end
@implementation SchoolDataSource
-(instancetype)init{
    if (self = [super init]) {
        _placeArray = @[].mutableCopy;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _placeArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_placeArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRSchoolTableCell *cell = [tableView dequeueReusableCellWithIdentifier:schoolCellID];
    if (!cell) {
        cell = [[YRSchoolTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:schoolCellID];
    }
    cell.model =_placeArray[indexPath.section][indexPath.row];
    return cell;
}
-(void)getDataWithParameters:(NSDictionary*)parameters{
    _page = 0;
    _parameters = parameters.mutableCopy;
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_PLACES parameters:parameters complete:^(NSDictionary *responseDic) {
        NSArray *places = [YRSchoolModel mj_objectArrayWithKeyValuesArray:responseDic];
        [_placeArray removeAllObjects];
        [_placeArray addObject:places];
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
    [RequestData GET:STUDENT_PLACES parameters:_parameters complete:^(NSDictionary *responseDic) {
        NSArray *places = [YRSchoolModel mj_objectArrayWithKeyValuesArray:responseDic];
        if (places.count == 0) {
            [MBProgressHUD hideHUDForView:self.table animated:YES];
            [self.table.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [_placeArray addObject:places];
        [self.table insertSections:[NSIndexSet indexSetWithIndex:_page] withRowAnimation:UITableViewRowAnimationNone];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
@end
