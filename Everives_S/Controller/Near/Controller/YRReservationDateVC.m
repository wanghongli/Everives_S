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
static NSInteger sectionNum = 7;
static NSInteger rowNum = 6;
@interface YRReservationDateVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_dateArray;//显示在顶部不带年份
    NSArray *_dateAyyayWithYear;//用于返回数据,带年份
    NSArray *_timeStartArray;
    NSArray *_timeEndArray;
    NSArray *_modelArray;
    
}
@property(nonatomic,strong) UICollectionView *collectionView;
@end
@implementation YRReservationDateVC
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick:)];
    [self.view addSubview:self.collectionView];
    [self initTime];
    [self getData];
}
-(void)initTime{
    NSMutableArray *days = @[].mutableCopy;
    NSMutableArray *days2 = @[].mutableCopy;
    for (NSInteger i = 0; i<rowNum; i++) {
        NSDate *firstDay = [[NSDate date] dateByAddingTimeInterval:3600*24*(i-1)];
        NSString *dayStr = [NSString dateStringWithInterval:[NSString stringWithFormat:@"%f",firstDay.timeIntervalSince1970]];
        [days2 addObject:dayStr];
        dayStr = [dayStr substringFromIndex:5];
        [days addObject:dayStr];
    }
    days[1] = @"今天";
    _dateArray = days.copy;
    _dateAyyayWithYear = days2.copy;
    _timeStartArray = @[@"09:00-",@"10:00-",@"11:00-",@"14:00-",@"15:00-",@"16:00-",@"17:00-"];
    _timeEndArray = @[@"10:00",@"11:00",@"12:00",@"15:00",@"16:00",@"17:00",@"18:00"];
}
-(void)commitBtnClick:(UIBarButtonItem*)sender{
    YRReservationChoosePlaceVC *choosePlace = [[YRReservationChoosePlaceVC alloc]init];
    [self.navigationController pushViewController:choosePlace animated:YES];
}
-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_AVAILTIME,_coachID] parameters:nil complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        _modelArray = [YRReservationModel mj_objectArrayWithKeyValuesArray:responseDic];
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
static NSInteger x=0;
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YRDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.priceLabel.text = @"";
    cell.timeStart.text = @"";
    cell.timeEnd.text = @"";
    if (indexPath.section == 0) { //第一行
        if (indexPath.row != 0) {
            cell.priceLabel.text = _dateArray[indexPath.row-1];
        }
    }else if (indexPath.row == 0) {  //第一列
        cell.timeStart.text = _timeStartArray[indexPath.section-1];
        cell.timeEnd.text = _timeEndArray[indexPath.section-1];
    }else{
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YRReservationModel *model = (YRReservationModel*)obj;
            if([model.date isEqualToString:_dateAyyayWithYear[indexPath.row-1]]){
                if ([model.time integerValue] == indexPath.section) {
                    cell.priceLabel.text = model.price;
                }
            }
            x++;
            NSLog(@"%li",x);
        }];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - Getters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(kScreenWidth/rowNum, (kScreenHeight-30)/sectionNum);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[YRDateCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}
@end
