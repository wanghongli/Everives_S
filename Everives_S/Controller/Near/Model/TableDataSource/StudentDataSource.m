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
static NSString * studentCellID = @"YRStudentTableCellID";
@interface StudentDataSource ()

@end
@implementation StudentDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _stuArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRStudentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:studentCellID];
    if (!cell) {
        cell = [[YRStudentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studentCellID];
    }
    cell.model =_stuArray[indexPath.row];
    return cell;
}
-(void)getData{
    NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude};
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_NEARBY parameters:parameters complete:^(NSDictionary *responseDic) {
        _stuArray = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
@end
