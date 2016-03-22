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
static NSString * schoolCellID = @"YRSchoolTableCellID";
@interface SchoolDataSource ()

@end
@implementation SchoolDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _placeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRSchoolTableCell *cell = [tableView dequeueReusableCellWithIdentifier:schoolCellID];
    if (!cell) {
        cell = [[YRSchoolTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:schoolCellID];
    }
    cell.model =_placeArray[indexPath.row];
    return cell;
}
-(void)getData{
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude,@"sort":@0,@"address":@"",@"key":@""};
    [RequestData GET:STUDENT_PLACES parameters:parameters complete:^(NSDictionary *responseDic) {
        _placeArray = [YRSchoolModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
@end
