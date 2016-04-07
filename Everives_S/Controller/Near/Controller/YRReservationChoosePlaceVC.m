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
#import "NSString+Tools.h"
#import "YRReservationDateVC.h"
static NSString *HeaderID = @"headerID";

@interface YRReservationChoosePlaceVC (){
    NSMutableArray *_modelArrays;//元素是对应时段的场地数组
    NSMutableDictionary *_selectedDic;//元素是indexpath
    NSMutableArray *_parameterArr;//提交给服务器的数组
    NSArray *_times;
}
@end

@implementation YRReservationChoosePlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约场地";
    _selectedDic = @{}.mutableCopy;
    _modelArrays = @[].mutableCopy;
    _parameterArr = @[].mutableCopy;
    _times = @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"];
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
    NSDictionary *parameters = @{@"id":_coachID,@"partner":@"0",@"info":[_parameterArr mj_JSONString],@"kind":@"0"};
    NSLog(@"%@",parameters[@"info"]);
    [RequestData POST:STUDENT_ORDER parameters:parameters complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        [MBProgressHUD showSuccess:@"预约成功" toView:self.view];
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YRReservationDateVC class]]) {
                [array removeObject:obj];
            }
            
        }];
        self.navigationController.viewControllers = array;
        [self.navigationController popViewControllerAnimated:YES];
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
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderID];
    }
    NSString *date = _timeArray[section][@"date"];
    NSString *time = _times[[_timeArray[section][@"time"] integerValue]];
    NSString *str =[NSString stringWithFormat:@"您已预约%@教练 科目二，时间%@,%@,请选择本次学车场地",_coachName?:@"罗纳尔多",date,time];
    UIFont *font = [UIFont systemFontOfSize:17];
    CGSize size = [str sizeWithFont:font maxSize:CGSizeMake(kScreenWidth-16, 100)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, (80-size.height)/2, kScreenWidth-16, size.height)];
    label.font = font;
    label.text = str;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    
    [header.contentView addSubview:label];
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
