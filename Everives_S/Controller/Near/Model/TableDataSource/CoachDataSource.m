//
//  YRCoachDataSource.m
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "CoachDataSource.h"
#import "YRCoachTableCell.h"
static NSString * coachCellID = @"YRCoachTableCellID";
@implementation CoachDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRCoachTableCell *cell = [tableView dequeueReusableCellWithIdentifier:coachCellID];
    if (!cell) {
        cell = [[YRCoachTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:coachCellID];
    }
    return cell;
}
@end
