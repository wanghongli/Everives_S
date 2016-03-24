//
//  YRReservationChoosePlaceVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationChoosePlaceVC.h"
#import "RequestData.h"
#import "YRBriefPlaceModel.h"
#import "YRChoosePlaceCell.h"
@interface YRReservationChoosePlaceVC (){
    NSMutableArray *_modelArrays;//元素是对应时段的场地数组
    NSMutableDictionary *_selectedDic;//元素是indexpath
    NSMutableArray *_parameterArr;
}
@end

@implementation YRReservationChoosePlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedDic = @{}.mutableCopy;
    _modelArrays = @[].mutableCopy;
    _parameterArr = @[].mutableCopy;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 50;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.editing = YES;
    [self getData];
}
- (void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_AVAILPLACE,_coachID] parameters:@{@"data":[_timeArray mj_JSONString]} complete:^(NSDictionary *responseDic) {
        
        [((NSArray*)responseDic) enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_modelArrays addObject:[YRBriefPlaceModel mj_objectArrayWithKeyValuesArray:obj]];
        }];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
-(void)commitBtnClick:(UIBarButtonItem*)sender{
    
    [_timeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger rowSelected = ((NSIndexPath*)_selectedDic[[NSNumber numberWithInteger:idx]]).row;
        NSInteger sectionSelected = ((NSIndexPath*)_selectedDic[[NSNumber numberWithInteger:idx]]).section;
        NSString *placeID = ((YRBriefPlaceModel*)(_modelArrays[sectionSelected][rowSelected])).id;
        NSDictionary *dic = @{@"date":obj[@"date"],@"time":obj[@"time"],@"place":placeID};
        [_parameterArr addObject:dic];
    }];
    NSDictionary *parameters = @{@"id":_coachID,@"partner":@"0",@"info":[_parameterArr mj_JSONString]};
    NSLog(@"%@",_selectedDic);
    [RequestData POST:STUDENT_ORDER parameters:parameters complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
    } failed:^(NSError *error) {
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _modelArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_modelArrays[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *HeaderID = @"headerID";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderID];
    }
    header.textLabel.text = [NSString stringWithFormat:@"%@  %@",_timeArray[section][@"date"],_timeArray[section][@"time"]];
    return header;
}
static NSString *reuseID = @"reuseIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRChoosePlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[YRChoosePlaceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.place = (YRBriefPlaceModel*)(_modelArrays[indexPath.section][indexPath.row]);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_selectedDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key integerValue] == indexPath.section) {
            [tableView deselectRowAtIndexPath:_selectedDic[key] animated:YES];
            [_selectedDic removeObjectForKey:key];
        }
    }];
    _selectedDic[[NSNumber numberWithInteger:indexPath.section]] = indexPath;
    if (_selectedDic.count == _timeArray.count) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_selectedDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj == indexPath) {
            [_selectedDic removeObjectForKey:key];
        }
    }];
    if (_selectedDic.count < _timeArray.count) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
@end
