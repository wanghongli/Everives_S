//
//  YRMyCoachVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyCoachVC.h"
#import "YRSearchFriendCell.h"
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "YRCoachModel.h"
static NSString *cellID = @"cellID";

@interface YRMyCoachVC(){
    NSArray *_coaches;
}
@end
@implementation YRMyCoachVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:cellID];
    if (_isAllowSelected) {
        [self.tableView setEditing:YES];
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
    }
    [self getData];
}
-(void)getData{
    [RequestData GET:STUDENT_TEACHERS parameters:nil complete:^(NSDictionary *responseDic) {
        _coaches = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
    } failed:^(NSError *error) {
        
    }];
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _coaches.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YRSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cellID) {
        cell = [[YRSearchFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.avatar sd_setImageWithURL:[NSURL URLWithString:[_coaches[indexPath.row] avatar]]];
    cell.name.text = [_coaches[indexPath.row] name];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
@end