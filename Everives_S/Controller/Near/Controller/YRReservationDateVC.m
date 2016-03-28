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
#import "YRReservationModel.h"
static NSInteger sectionNum = 8;//竖着的那种
static NSInteger rowNum = 8; //横着的那种
@interface YRReservationDateVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSArray *_dateArray;//显示在顶部不带年份
    NSArray *_dateAyyayWithYear;//带年份
    NSArray *_timeStartArray;
    NSArray *_timeEndArray;
    NSArray *_modelArray;
    NSMutableArray *_result;//元素是indexpath
    NSMutableArray *_cannotSelected;////元素是indexpath
    
}
@property(nonatomic,strong) UICollectionView *collectionView;
@end
@implementation YRReservationDateVC
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick:)];
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
-(void)commitBtnClick:(UIBarButtonItem*)sender{
    NSMutableArray *resultDate=@[].mutableCopy;
    [_result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dic = @{@"date":_dateAyyayWithYear[((NSIndexPath*)obj).section-1],@"time":[NSString stringWithFormat:@"%li",((NSIndexPath*)obj).row]};
        [resultDate addObject:dic];
    }];
    YRReservationChoosePlaceVC *choosePlace = [[YRReservationChoosePlaceVC alloc]init];
    choosePlace.timeArray = resultDate;
    choosePlace.coachID = _coachID;
    [self.navigationController pushViewController:choosePlace animated:YES];
}
-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_AVAILTIME,_coachID] parameters:nil complete:^(NSDictionary *responseDic) {
        _modelArray = [YRReservationModel mj_objectArrayWithKeyValuesArray:responseDic];
        [_cannotSelected removeAllObjects];
        [self.collectionView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
    cell.timeStart.text = @"";
    cell.timeEnd.text = @"";
    if (indexPath.row == 0) { //第一行
        if (indexPath.section != 0) {
            cell.priceLabel.text = _dateArray[indexPath.section-1];
        }
    }else if (indexPath.section == 0) {  //第一列
        cell.timeStart.text = _timeStartArray[indexPath.row-1];
        cell.timeEnd.text = _timeEndArray[indexPath.row-1];
    }else{
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YRReservationModel *model = (YRReservationModel*)obj;
            if([model.date isEqualToString:_dateAyyayWithYear[indexPath.section-1]]){
                if ([model.time integerValue] == indexPath.row) {
                    cell.priceLabel.text = [model.price isEqualToString:@"-1"]?@"已被预约":[NSString stringWithFormat:@"￥%@",model.price];
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
    
}
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cannotSelected containsObject:indexPath]) {
        return;
    }
    [_result removeObject:indexPath];
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([_cannotSelected containsObject:indexPath]) {
        return NO;
    }
    return YES;
}
#pragma mark - Getters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kScreenWidth/6, ([[UIScreen mainScreen]bounds].size.height-64)/sectionNum);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, [[UIScreen mainScreen]bounds].size.height) collectionViewLayout:layout];
        [_collectionView registerClass:[YRDateCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        
    }
    return _collectionView;
}
@end