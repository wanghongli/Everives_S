//
//  YRReservationDateVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationDateVC.h"
#import "YRDateCell.h"
#import "YRReservationChoosePlaceVC.h"
#import "NSString+Tools.h"
#import "RequestData.h"
#import "YRCanOrderPlacesModel.h"
#import "YROrderConfirmViewController.h"
#import "YRTeacherDetailObj.h"
static NSInteger sectionNum = 7;//竖着的那种
static NSInteger rowNum = 8; //横着的那种
#define kcellHeight (kScreenHeight-64)/rowNum
#define kcellWidth 62.5

@interface YRReservationDateVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource>{
    NSArray *_dateArray;//显示在顶部不带年份
    NSArray *_dateAyyayWithYear;//带年份
    NSArray *_timeStartArray;
    NSArray *_timeEndArray;
    NSArray *_modelArray;
    NSMutableArray *_result;//元素是indexpath
    NSMutableArray *_cannotSelected;////元素是indexpath
    
}
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UITableView *timeView;
@end
@implementation YRReservationDateVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"预约时间";
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.view addSubview:self.timeView];
    [self.view addSubview:self.collectionView];
    [self initSome];
    [self getData];
    
}
-(void)initSome{
    _result = @[].mutableCopy;
    _cannotSelected = @[].mutableCopy;
    NSMutableArray *days = @[].mutableCopy;
    NSMutableArray *days2 = @[].mutableCopy;
    for (NSInteger i = 0; i<sectionNum; i++) {
        NSDate *firstDay = [[NSDate date] dateByAddingTimeInterval:3600*24*i];
        NSString *dayStr = [NSString dateStringWithInterval:[NSString stringWithFormat:@"%f",firstDay.timeIntervalSince1970]];
        [days2 addObject:dayStr];
        dayStr = [dayStr substringFromIndex:5];
        [days addObject:dayStr];
    }
    days[0] = @"今天";
    _dateArray = days.copy;
    _dateAyyayWithYear = days2.copy;
    _timeStartArray = @[@"09:00-",@"10:00-",@"11:00-",@"14:00-",@"15:00-",@"16:00-",@"17:00-"];
    _timeEndArray = @[@"10:00",@"11:00",@"12:00",@"15:00",@"16:00",@"17:00",@"18:00"];
}

-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@%li",STUDENT_AVAILTIME,_coachModel.id] parameters:nil complete:^(NSDictionary *responseDic) {
        _modelArray = [YRCanOrderPlacesModel mj_objectArrayWithKeyValuesArray:responseDic];
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YRCanOrderPlacesModel *model = (YRCanOrderPlacesModel*)obj;
            [_dateAyyayWithYear enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([model.date isEqualToString:_dateAyyayWithYear[idx]]){
                    model.section = idx;
                }
            }];
            model.row = [model.time integerValue];
        }];
        [_cannotSelected removeAllObjects];
        [self.collectionView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)commitBtnClick:(UIBarButtonItem*)sender{
    
    [_result sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSInteger r1 = [obj1 row];
        NSInteger r2 = [obj2 row];
        NSInteger s1 =[obj1 section];
        NSInteger s2 = [obj2 section];
        if (s1 > s2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (s1 < s2) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        if (r1 > r2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (r1 < r2) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    NSMutableArray *resultDate=@[].mutableCopy;
    __block NSInteger totalPrice = 0;
    [_result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = obj;
        NSDictionary *dic = @{@"date":_dateAyyayWithYear[indexPath.section],@"time":[NSString stringWithFormat:@"%ld",(long)indexPath.row],@"place":@"0"};
        [resultDate addObject:dic];
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YRCanOrderPlacesModel *model = obj;
            if (model.section == indexPath.section && model.row == indexPath.row) {
                totalPrice += [model.price integerValue];
            }
        }];
    }];
    //如果是科目三就不再选择场地，直接提交
    if (_coachModel.kind == 1) {
        
        NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%li",_coachModel.id],@"partner":@"0",@"info":[resultDate mj_JSONString],@"kind":@"1"};
        YROrderConfirmViewController *confirmVC = [[YROrderConfirmViewController alloc] init];
        confirmVC.parameters = parameters;
        confirmVC.DateTimeArray = resultDate;
        confirmVC.coachModel = _coachModel;
        confirmVC.totalPrice = totalPrice;
        [self.navigationController pushViewController:confirmVC animated:YES];
    }else{//如果是科目二则继续选择场地
        YRReservationChoosePlaceVC *choosePlace = [[YRReservationChoosePlaceVC alloc]init];
        choosePlace.timeArray = resultDate;
        choosePlace.coachModel = _coachModel;
        choosePlace.totalPrice = totalPrice;
        [self.navigationController pushViewController:choosePlace animated:YES];
    }
}

static NSString *kCellIdentifier = @"kCellIdentifier";
#pragma mark -UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return rowNum;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return sectionNum;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YRDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.priceLabel.text = @"";
    cell.priceLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    if (indexPath.row == 0) { //第一行
        cell.priceLabel.text = _dateArray[indexPath.section];
        cell.priceLabel.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
        cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }else{
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YRCanOrderPlacesModel *model = (YRCanOrderPlacesModel*)obj;
            if (model.section == indexPath.section && model.row == indexPath.row) {
                if ([model.price isEqualToString:@"-1"]) {
                    cell.priceLabel.text = @"已被预约";
                    cell.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
                }else{
                    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
                }
            }
        }];
    }
    if (indexPath.section == 0||indexPath.row == 0||[cell.priceLabel.text isEqualToString:@"已被预约"]||[cell.priceLabel.text isEqualToString:@""]) {
        [_cannotSelected addObject:indexPath];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cannotSelected containsObject:indexPath]) {
        return;
    }
    [_result addObject:indexPath];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cannotSelected containsObject:indexPath]) {
        return;
    }
    [_result removeObject:indexPath];
    if (_result.count == 0) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cannotSelected containsObject:indexPath]) {
        return NO;
    }
    return YES;
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"tableCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    }
    if (indexPath.row == 0) {
        //表头
    }else{
        UILabel *startTime = [[UILabel alloc] initWithFrame:CGRectMake(0, kcellHeight/2-20, kcellWidth, 20)];
        startTime.font = kFontOfLetterMedium;
        startTime.text = _timeStartArray[indexPath.row-1];
        startTime.textAlignment = NSTextAlignmentCenter;
        startTime.textColor = [UIColor colorWithRed:54/255.0 green:93/255.0 blue:178/255.0 alpha:1];
        UILabel *endTime = [[UILabel alloc] initWithFrame:CGRectMake(0, kcellHeight/2, kcellWidth, 20)];
        endTime.font = kFontOfLetterMedium;
        endTime.text = _timeEndArray[indexPath.row-1];
        endTime.textAlignment = NSTextAlignmentCenter;
        endTime.textColor = [UIColor colorWithRed:54/255.0 green:93/255.0 blue:178/255.0 alpha:1];
        [cell.contentView addSubview:startTime];
        [cell.contentView addSubview:endTime];
    }
    return cell;
}
#pragma mark - Getters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kcellWidth, kcellHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kcellWidth, 64, kcellWidth*5, kScreenHeight-64) collectionViewLayout:layout];
        [_collectionView registerClass:[YRDateCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        
    }
    return _collectionView;
}
-(UITableView *)timeView{
    if (!_timeView) {
        _timeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kcellWidth, kScreenHeight)];
        _timeView.rowHeight = kcellHeight;
        _timeView.dataSource = self;
        _timeView.scrollEnabled = NO;
    }
    return _timeView;
}
@end
