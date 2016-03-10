//
//  SchoolDataSource.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "SchoolDataSource.h"
#import "YRSchoolTableCell.h"
static NSString * schoolCellID = @"YRSchoolTableCellID";
@implementation SchoolDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRSchoolTableCell *cell = [tableView dequeueReusableCellWithIdentifier:schoolCellID];
    if (!cell) {
        cell = [[YRSchoolTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:schoolCellID];
    }
    return cell;
}
@end
