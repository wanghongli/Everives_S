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
#import "YRShareOrderConfirmViewController.h"
#import "YRLineView.h"
#import "UIColor+Tool.h"
#import "YRTimeCell.h"
#import "YRDatesCollectionView.h"
#import "YRSharedDateArray.h"

static NSInteger sectionNum = 7;//竖着的那种
static NSInteger rowNum = 13; //横着的那种
#define kdateHeight 50
#define kcellHeight ((kScreenHeight-64-kdateHeight-5)/7)
#define kcellWidth 62.5

@interface YRReservationDateVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>{
    NSArray *_dateArray;//显示在顶部不带年份
    NSArray *_dateAyyayWithYear;//带年份
    NSArray *_timeStartArray;
    NSArray *_timeEndArray;
    NSArray *_timeNumArray;
    NSArray *_modelArray;
    NSMutableArray *_result;//元素是indexpath
    NSMutableArray *_cannotSelected;////元素是indexpath
    
}
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UITableView *timeView;
@property(nonatomic,strong) YRDatesCollectionView *dateView;
@end
@implementation YRReservationDateVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"预约时间";
    self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick:)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [[YRSharedDateArray sharedInstance] setTimeArraysByArray:@[@"8",@"9",@"10",@"11",@"15.5",@"16.5",@"17.5",@"18.5",@"20",@"21"]];
    [self initSome];
    [self getData];
    [self.view addSubview:self.timeView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.dateView];
    
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
    _timeStartArray = [YRSharedDateArray sharedInstance].timeStartArray;
    _timeEndArray = [YRSharedDateArray sharedInstance].timeEndArray;
    _timeNumArray = [YRSharedDateArray sharedInstance].timeNumArray;
    rowNum = [YRSharedDateArray sharedInstance].timeArray.count;
}

-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@%li",STUDENT_AVAILTIME,_coachModel.id] parameters:nil complete:^(NSDictionary *responseDic) {
        _modelArray = [YRCanOrderPlacesModel mj_objectArrayWithKeyValuesArray:responseDic];
        [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YRCanOrderPlacesModel *model = (YRCanOrderPlacesModel*)obj;
            model.section = [_dateAyyayWithYear indexOfObject:model.date];
            model.row = [_timeNumArray indexOfObject:model.time];
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
        NSDictionary *dic = @{@"date":_dateAyyayWithYear[indexPath.section],@"time":[_timeNumArray objectAtIndex:indexPath.row],@"place":@"0"};
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
        
        NSDictionary *parameters = @{@"id":[NSString stringWithFormat:@"%li",_coachModel.id],@"partner":_isShareOrder?_partnerModel.id:@"0",@"info":[resultDate mj_JSONString],@"kind":@"1"};
        //合拼教练
        if (_isShareOrder) {
            YRShareOrderConfirmViewController *confirmVC = [[YRShareOrderConfirmViewController alloc] init];
            confirmVC.parameters = parameters;
            confirmVC.DateTimeArray = resultDate;
            confirmVC.coachModel = _coachModel;
            confirmVC.totalPrice = totalPrice;
            confirmVC.partnerModel = _partnerModel;
            [self.navigationController pushViewController:confirmVC animated:YES];
        }else{
            YROrderConfirmViewController *confirmVC = [[YROrderConfirmViewController alloc] init];
            confirmVC.parameters = parameters;
            confirmVC.DateTimeArray = resultDate;
            confirmVC.coachModel = _coachModel;
            confirmVC.totalPrice = totalPrice;
            [self.navigationController pushViewController:confirmVC animated:YES];
        }
        
    }else{//如果是科目二则继续选择场地
        YRReservationChoosePlaceVC *choosePlace = [[YRReservationChoosePlaceVC alloc]init];
        choosePlace.timeArray = resultDate;
        choosePlace.coachModel = _coachModel;
        choosePlace.totalPrice = totalPrice;
        choosePlace.isShareOrder = _isShareOrder;
        choosePlace.partnerModel = _partnerModel;
        NSLog(@"%@",resultDate);
        [self.navigationController pushViewController:choosePlace animated:YES];
    }
}
#pragma mark - panGestureHandle
-(void)panGestureHandle:(UIPanGestureRecognizer*)gesture{
    static CGFloat x = 0;
    static CGFloat y = 0;
    static NSInteger direction;//1左右  2上下
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CGPoint movedPoint = [gesture translationInView:self.view];
        CGFloat changeX = movedPoint.x;
        CGFloat changeY = movedPoint.y;
        if (fabs(changeX)>fabs(changeY)) {
            direction = 1;
        }else{
            direction = 2;
        }
        
    }
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGFloat changeX = 0;
        CGFloat changeY = 0;
        CGPoint movedPoint = [gesture translationInView:self.view];
        changeX = movedPoint.x - x;
        changeY = movedPoint.y -y;
        if (direction == 1) {
            x = movedPoint.x;
            changeY = 0;
        }else{
            y = movedPoint.y;
            changeX = 0;
        }
        CGPoint contentOffset = _collectionView.contentOffset;
        [_collectionView setContentOffset:CGPointMake(contentOffset.x-changeX, contentOffset.y-changeY) animated:NO];
        
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        x = 0;
        y = 0;
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    //限制_colloctionView的左右滑动范围
    if (point.x>2*kcellWidth) {
        point.x =2*kcellWidth;
    }else if(point.x<0){
        point.x = 0;
    }
    //_collectionView只影响dateView的X  不影响它的Y
    [self.dateView.collectionView setContentOffset:CGPointMake(point.x, 0) animated:NO];
    //限制_colloctionView的上下滑动范围
    if (point.y<0) {
        point.y = 0;
    }else if(point.y> (rowNum-7)*kcellHeight){
        point.y = (rowNum-7)*kcellHeight;
    }
    //_collectionView只影响timeView的Y  不影响它的X
    [self.timeView setContentOffset:CGPointMake(0, point.y) animated:NO];
    [_collectionView setContentOffset:point];
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
    [_modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YRCanOrderPlacesModel *model = (YRCanOrderPlacesModel*)obj;
        if (model.section == indexPath.section && model.row == indexPath.row) {
            if ([model.price isEqualToString:@"-1"]) {
                cell.priceLabel.text = @"已被预约";
                cell.backgroundColor = [UIColor colorWithRGB:0x79c5c2];
            }else{
                cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
            }
        }
    }];
    if ([cell.priceLabel.text isEqualToString:@"已被预约"]||[cell.priceLabel.text isEqualToString:@""]) {
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
    //判断 今天必须提前两小时安排预约
    if (indexPath.section == 0) {
        NSDate *now = [NSDate date];
        NSString *nowTimeStr = [NSString dateStringWithAllInterval:[NSString stringWithFormat:@"%f",now.timeIntervalSince1970]];
        NSString *hour = [nowTimeStr substringWithRange:NSMakeRange(11, 2)];
        NSInteger hourInt = [hour integerValue];
        NSInteger selectedHour = [_timeNumArray[indexPath.row] integerValue];
        if (selectedHour - hourInt <2) {
            return;
        }
        NSLog(@"%li  %li",hourInt,selectedHour);
    }

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
    return rowNum;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"tableCellID";
    YRTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YRTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.layer.borderColor = kCOLOR(206, 206, 206).CGColor;
        cell.layer.borderWidth = 0.3;
    }
    [cell configCellWithStratTime:_timeStartArray[indexPath.row] endTime:_timeEndArray[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *sectionHeaderID = @"sectionHeader";
    UITableViewHeaderFooterView *headr = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderID];
    if (!headr) {
        headr = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:sectionHeaderID];
    }
    YRLineView *line = [[YRLineView alloc] initWithFrame:CGRectMake(0, 0, kcellWidth, 50)];
    line.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    
    UILabel *timeL = [[UILabel alloc] initWithFrame:CGRectMake(kcellWidth/2, 12, kcellWidth, 15)];
    timeL.text = @"日期";
    timeL.font = kFontOfLetterMedium;
    UILabel *dateL = [[UILabel alloc] initWithFrame:CGRectMake(6, 27, kcellWidth, 15)];
    dateL.text = @"时段";
    dateL.font = kFontOfLetterMedium;
    [headr.contentView addSubview:line];
    [headr.contentView addSubview:timeL];
    [headr.contentView addSubview:dateL];
    
    return headr;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kdateHeight;
}
#pragma mark - Getters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kcellWidth, kcellHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kcellWidth, kdateHeight, kScreenWidth-kcellWidth, rowNum*kcellHeight) collectionViewLayout:layout];
        [_collectionView registerClass:[YRDateCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandle:)];
        [_collectionView addGestureRecognizer:pan];
    }
    return _collectionView;
}
-(UITableView *)timeView{
    if (!_timeView) {
        _timeView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kcellWidth, kScreenHeight)];
        _timeView.dataSource = self;
        _timeView.delegate = self;
        _timeView.scrollEnabled = NO;
        _timeView.rowHeight = kcellHeight;
    }
    return _timeView;
}
-(YRDatesCollectionView *)dateView{
    if (!_dateView) {
        _dateView = [[YRDatesCollectionView alloc] initWithFrame:CGRectMake(kcellWidth, 0, kScreenWidth-kcellWidth, kdateHeight)];
    }
    return _dateView;
}

@end
