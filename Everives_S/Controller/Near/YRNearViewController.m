//
//  YRNearViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRNearViewController.h"
#import "SharedMapView.h"
#import "REFrostedViewController.h"
#import "YRMapSelectView.h"
#import "SchoolDataSource.h"
#import "CoachDataSource.h"
#import "StudentDataSource.h"
#import "YRSchoolCelldetailVC.h"
#import "YRFillterBtnView.h"
#import "YRSchoolModel.h"
#import "YRPictureModel.h"
#import "YRCoachModel.h"
#import "YRUserDetailController.h"
#import "YRTeacherDetailController.h"
#import "YRCoachCellDetailVC.h"
//定义三个table的类型
typedef NS_ENUM(NSUInteger,NearTableType){
    NearTableTypeSchool = 1,
    NearTableTypeCoach,
    NearTableTypeStudent
};
static NSString *schoolCellID = @"YRSchoolTableCellID";
static NSString *coachCellID = @"YRCoachTableCellID";
static NSString *studentCellID = @"YRStudentTableCellID";

@interface YRNearViewController ()<YRMapSelectViewDelegate,UITableViewDelegate,UISearchBarDelegate>{
    MAMapView *_mapView;
    YRMapSelectView *_selectView;
    BOOL _isMapView;
    
    SchoolDataSource *_schoolData;
    CoachDataSource *_coachData;
    StudentDataSource *_studentData;
    
    NSArray *_schoolForMap;
    NSArray *_coachForMap;
    NSArray *_stuForMap;
}
@property(nonatomic,strong) UITableView *schoolTable;
@property(nonatomic,strong) UITableView *coachTable;
@property(nonatomic,strong) UITableView *studentTable;
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) YRFillterBtnView *schoolFillterView;
@property(nonatomic,strong) YRFillterBtnView *coachFillterView;
@end

@implementation YRNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(changeViewClick:)];
    _isMapView = YES;
    _mapView = [SharedMapView sharedInstance].mapView;
    _selectView = [[YRMapSelectView alloc] init];
    _selectView.delegate = self;
    [self.view addSubview:_mapView];
    [self.view addSubview:_selectView];
    [_mapView addSubview:self.searchBar];
    [self getDataForMap:1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tablewViewReloadData:) name:@"FillterNotification" object:nil];
}


#pragma mark - Private Methods
//收到筛选信息之后的通知处理
-(void)tablewViewReloadData:(NSNotification*)notification{
    NSDictionary *dic = notification.userInfo;
    if ([dic[@"tabletag"] integerValue] == NearTableTypeSchool) {
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude,@"sort":_schoolFillterView.sort?:@"0",@"address":_schoolFillterView.addr?:@"",@"key":@""};
        [_schoolData getDataWithParameters:parameters];
    }else{
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude,@"sort":_coachFillterView.sort?:@"0",@"address":_coachFillterView.addr?:@"",@"key":@""};
        [_coachData getDataWithParameters:parameters];
    }
}
-(void)getDataForMap:(NSInteger) kind{
    [RequestData GET:SYUDENT_NEARBYPOINT parameters:@{@"kind":[NSNumber numberWithInteger:kind],@"lat":KUserLocation.latitude?:KUserManager.lat,@"lng":KUserLocation.longitude?:KUserManager.lng,@"time":@""} complete:^(NSDictionary *responseDic) {
        switch (kind) {
            case 1:{
                _schoolForMap = [YRSchoolModel mj_objectArrayWithKeyValuesArray:responseDic];
                [_schoolForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj setCoordinate:CLLocationCoordinate2DMake([[obj lat] doubleValue],[[obj lng] doubleValue])];
                    if ([obj pics].count) {
                        [obj setImaageurl:((YRPictureModel*)([obj pics][0])).url];
                    }
                }];
                break;
            }
            case 2:{
                _coachForMap = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
                [_coachForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj setCoordinate:CLLocationCoordinate2DMake([[obj lat] doubleValue],[[obj lng] doubleValue])];
//                    [obj setImaageurl:[obj avatar]];
                }];
                break;
            }
            case 3:{
                _stuForMap = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
                [_stuForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj setCoordinate:CLLocationCoordinate2DMake([[obj lat] doubleValue],[[obj lng] doubleValue])];
//                    [obj setImaageurl:[obj avatar]];
                }];
                break;
            }
            default:
                break;
        }
        [self addAnnotationswithType:kind];
    } failed:^(NSError *error) {
        
    }];
}

-(void)addAnnotationswithType:(NSInteger) kind{
    
    switch (kind) {
        case 1:{
            [_mapView addAnnotations:_schoolForMap];
            break;
        }
        case 2:{
            [_mapView addAnnotations:_coachForMap];
            break;
        }
        case 3:{
            [_mapView addAnnotations:_stuForMap];
            break;
        }
        default:
            break;
    }
}

- (void)backBtnClick:(UIBarButtonItem*)sender{
    [self.frostedViewController presentMenuViewController];
}

- (void)changeViewClick:(UIBarButtonItem*)sender{
    if (_isMapView) {
        _isMapView = NO;
        switch (_selectView.selectedBtnNum) {
            case 1:{
                [self.view addSubview:self.schoolTable];
                break;
            }
            case 2:{
                [self.view addSubview:self.coachTable];
                break;
            }
            case 3:{
                [self.view addSubview:self.studentTable];
                break;
            }
            default:
                break;
        }
    }else{
        _isMapView = YES;
        switch (_selectView.selectedBtnNum) {
            case 1:{
                [self.schoolTable removeFromSuperview];
                break;
            }
            case 2:{
                [self.coachTable removeFromSuperview];
                break;
            }
            case 3:{
                [self.studentTable removeFromSuperview];
                break;
            }
            default:
                break;
        }
    }
}
#pragma mark - YRMapSelectViewDelegate
-(void)schoolBtnClick:(UIButton *)sender{
    if (sender.tag == _selectView.selectedBtnNum) {
        return;
    }
    [self removeLastTable];
    _searchBar.hidden = NO;
    [_mapView removeAnnotations:_coachForMap];
    [_mapView removeAnnotations:_stuForMap];
    [self addAnnotationswithType:1];
}
-(void)coachBtnClick:(UIButton*)sender{
    if (sender.tag == _selectView.selectedBtnNum) {
        return;
    }
    [self removeLastTable];
    _searchBar.hidden = NO;
    [_mapView removeAnnotations:_schoolForMap];
    [_mapView removeAnnotations:_stuForMap];
    [self getDataForMap:2];
}
-(void)studentBtnClick:(UIButton*)sender{
    if (sender.tag == _selectView.selectedBtnNum) {
        return;
    }
    [self removeLastTable];
    _searchBar.hidden = YES;
    [_mapView removeAnnotations:_schoolForMap];
    [_mapView removeAnnotations:_coachForMap];
    [self getDataForMap:3];
}
-(void)removeLastTable{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UITableView class]]){
            [obj removeFromSuperview];
        }
    }];
    _isMapView = YES;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == NearTableTypeSchool) {
        YRSchoolCelldetailVC *schoolDetail = [[YRSchoolCelldetailVC alloc] init];
        schoolDetail.placeID = [_schoolData.placeArray[indexPath.row] id];
        [self.navigationController pushViewController:schoolDetail animated:YES];
    }else if(tableView.tag == NearTableTypeCoach){
        YRCoachCellDetailVC *coachDetail = [[YRCoachCellDetailVC alloc] init];
        coachDetail.coachID = [_coachData.coachArray[indexPath.row] id];
        [self.navigationController pushViewController:coachDetail animated:YES];
//        YRTeacherDetailController *coachDetail = [[YRTeacherDetailController alloc] init];
//        coachDetail.coachID = [_coachData.coachArray[indexPath.row] id];
//        [self.navigationController pushViewController:coachDetail animated:YES];
    }else{
        YRUserDetailController *userDetail = [[YRUserDetailController alloc] init];
        userDetail.userID = [_studentData.stuArray[indexPath.row] id];
        [self.navigationController pushViewController:userDetail animated:YES];
    }
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
#pragma mark - Getters
-(UITableView *)schoolTable{
    if (!_schoolTable) {
        _schoolTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight)];
        _schoolTable.tableHeaderView = self.schoolFillterView;
        _schoolTable.tableFooterView = [[UIView alloc]init];
        [_schoolTable registerNib:[UINib nibWithNibName:@"YRSchoolTableCell" bundle:nil] forCellReuseIdentifier:schoolCellID];
        _schoolTable.rowHeight = 100;
        
        _schoolData = [[SchoolDataSource alloc]init];
        _schoolData.table = _schoolTable;
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude,@"sort":@"0",@"address":@"",@"key":@""};
        [_schoolData getDataWithParameters:parameters];
        _schoolTable.dataSource = _schoolData;
        _schoolTable.tag = NearTableTypeSchool;
        _schoolTable.delegate = self;
    }
    return _schoolTable;
}
-(UITableView *)coachTable{
    if (!_coachTable) {
        _coachTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight)];
        _coachTable.tableHeaderView = self.coachFillterView;
        _coachTable.tableFooterView = [[UIView alloc]init];
        [_coachTable registerNib:[UINib nibWithNibName:@"YRCoachTableCell" bundle:nil] forCellReuseIdentifier:coachCellID];
        _coachTable.rowHeight = 100;
        
        _coachData = [[CoachDataSource alloc] init];
        _coachData.table = _coachTable;
        _coachTable.dataSource = _coachData;
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude,@"sort":@"0",@"address":@"",@"key":@""};
        [_coachData getDataWithParameters:parameters];
        _coachTable.tag = NearTableTypeCoach;
        _coachTable.delegate = self;
    }
    return _coachTable;
}
-(UITableView *)studentTable{
    if (!_studentTable) {
        _studentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight)];
        [_studentTable registerNib:[UINib nibWithNibName:@"YRStudentTableCell" bundle:nil] forCellReuseIdentifier:studentCellID];
        _studentTable.rowHeight = 100;
        _studentData = [[StudentDataSource alloc] init];
        _studentData.table = _studentTable;
        _studentTable.dataSource = _studentData;
        [_studentData getData];
        _studentTable.tag = NearTableTypeStudent;
        _studentTable.delegate = self;
        _studentTable.tableFooterView = [[UIView alloc]init];
    }
    return _studentTable;
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleProminent;
    }
    return _searchBar;

}
-(YRFillterBtnView *)schoolFillterView{
    if (!_schoolFillterView) {
        _schoolFillterView = [[YRFillterBtnView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, 44) titleArray:@[@"地区",@"排序方式"]];
        _schoolFillterView.tag = 1;
    }
    return _schoolFillterView;
}
-(YRFillterBtnView *)coachFillterView{
    if (!_coachFillterView) {
        _coachFillterView = [[YRFillterBtnView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, 44) titleArray:@[@"地区",@"排序方式"]];
        _coachFillterView.tag = 2;
    }
    return _coachFillterView;
}
@end
