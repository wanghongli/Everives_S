//
//  YRMyCoachVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyCoachVC.h"
#import "YRSearchFriendCell.h"
#import <MJExtension.h>
#import "YRCoachModel.h"
#import "YRTeacherDetailController.h"
static NSString *cellID = @"cellID";

@interface YRMyCoachVC(){
    NSArray *_coaches;
    NSMutableArray *_selectedArray;
}
@end
@implementation YRMyCoachVC
-(void)viewDidLoad{
    [super viewDidLoad];
    _selectedCoachIDArray = @[].mutableCopy;
    _selectedArray= @[].mutableCopy;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:cellID];
    if (_isAllowSelected) {
        self.tableView.editing = YES;
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeBtnClickWhenEditing)];
    }
    [self getData];
}

-(void)completeBtnClickWhenEditing{
    [_selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_selectedCoachIDArray addObject:@{@"id":[_coaches[[obj row]] id]}];
    }];
    if (_selectedArray.count == 1) {
        _selectedCoachName = [_coaches[[_selectedArray[0] row]] name];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getData{
    [RequestData GET:STUDENT_TEACHERS parameters:nil complete:^(NSDictionary *responseDic) {
        _coaches = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
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
    if (!cell) {
        cell = [[YRSearchFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configureCellWithAvatar:[_coaches[indexPath.row] avatar] name:[_coaches[indexPath.row] name]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAllowSelected) {
        if (![_selectedArray containsObject:indexPath]) {
            [_selectedArray addObject:indexPath];
        }
        return;
    }
    YRTeacherDetailController *vc = [[YRTeacherDetailController alloc]init];
    vc.teacherID = [_coaches[indexPath.row] id];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAllowSelected) {
        if ([_selectedArray containsObject:indexPath]) {
            [_selectedArray removeObject:indexPath];
        }
        return;
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
@end
