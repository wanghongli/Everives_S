//
//  StudentDataSource.m
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "StudentDataSource.h"
#import "YRStudentTableCell.h"
static NSString * studentCellID = @"YRStudentTableCellID";
@implementation StudentDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRStudentTableCell *cell = [tableView dequeueReusableCellWithIdentifier:studentCellID];
    if (!cell) {
        cell = [[YRStudentTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:studentCellID];
    }
    return cell;
}
@end
