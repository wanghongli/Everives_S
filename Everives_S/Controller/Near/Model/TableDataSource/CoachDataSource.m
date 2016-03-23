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
static NSString * coachCellID = @"YRCoachTableCellID";
@interface CoachDataSource ()

@end
@implementation CoachDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _coachArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRCoachTableCell *cell = [tableView dequeueReusableCellWithIdentifier:coachCellID];
    if (!cell) {
        cell = [[YRCoachTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coachCellID];
    }
    cell.model = _coachArray[indexPath.row];
    return cell;
}
-(void)getDataWithParameters:(NSDictionary*)parameters{
    [MBProgressHUD showHUDAddedTo:self.table animated:YES];
    [RequestData GET:STUDENT_NEARTEACHER parameters:parameters complete:^(NSDictionary *responseDic) {
        _coachArray = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.table reloadData];
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
        [MBProgressHUD hideHUDForView:self.table animated:YES];
    }];
}
@end
