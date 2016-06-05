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
#import "YROrderConfirmViewController.h"
#import "YRTeacherDetailObj.h"
#import "YRShareOrderConfirmViewController.h"
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
    [RequestData GET:[NSString stringWithFormat:@"%@%li",STUDENT_AVAILPLACE,_coachModel.id] parameters:@{@"data":[_timeArray mj_JSONString]} complete:^(NSDictionary *responseDic) {
        
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
    NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%li",_coachModel.id],@"partner":_isShareOrder?_partnerModel.id:@"0",@"info":[_parameterArr mj_JSONString],@"kind":@"0"};
    //合拼
    if (_isShareOrder) {
        YRShareOrderConfirmViewController *confirmVC = [[YRShareOrderConfirmViewController alloc] init];
        confirmVC.parameters = parameters;
        confirmVC.DateTimeArray = _parameterArr.copy;
        confirmVC.coachModel = _coachModel;
        confirmVC.totalPrice = _totalPrice;
        confirmVC.partnerModel = _partnerModel;
        [self.navigationController pushViewController:confirmVC animated:YES];
    }else{
        YROrderConfirmViewController *confirmVC = [[YROrderConfirmViewController alloc] init];
        confirmVC.parameters = parameters;
        confirmVC.DateTimeArray = _parameterArr.copy;
        confirmVC.coachModel = _coachModel;
        confirmVC.totalPrice = _totalPrice;
        [self.navigationController pushViewController:confirmVC animated:YES];
    }
    [_parameterArr removeAllObjects];
    
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _modelArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_modelArrays[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderID];
    }
    NSString *date = _timeArray[section][@"date"];
    NSString *time = _times[[_timeArray[section][@"time"] integerValue]-1];
    NSString *str =[NSString stringWithFormat:@"您已预约 %@ 教练 %@，时间 %@,%@,请选择本次学车场地",_coachModel.name,_coachModel.kind == 0?@"科目二":@"科目三",date,time];
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str];
    [astr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(5, _coachModel.name.length)];
    [astr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(9+_coachModel.name.length, 3)];
    [astr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(16+_coachModel.name.length, date.length)];
    [astr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(17+_coachModel.name.length+date.length, time.length)];
    UIFont *font = kFontOfLetterBig;
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(kScreenWidth-40, 100)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, (70-size.height)/2, kScreenWidth-40, size.height)];
    label.font = font;
    label.attributedText = astr;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    header.contentView.backgroundColor = [UIColor whiteColor];
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
