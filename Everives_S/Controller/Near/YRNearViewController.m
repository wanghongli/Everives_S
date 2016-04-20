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
#import "YRMapAnnotationView.h"
#import "YRMapFMDB.h"
#import "YRSliderView.h"
#import <MJRefresh.h>
//定义三个table的类型
typedef NS_ENUM(NSUInteger,NearTableType){
    NearTableTypeSchool = 1,
    NearTableTypeCoach,
    NearTableTypeStudent
};
static NSString *schoolCellID = @"YRSchoolTableCellID";
static NSString *coachCellID = @"YRCoachTableCellID";
static NSString *studentCellID = @"YRStudentTableCellID";

@interface YRNearViewController ()<YRMapSelectViewDelegate,UITableViewDelegate,UISearchBarDelegate,CallOutViewDelegate>{
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
@property(nonatomic,strong) UIButton *myLocationBtn;
@property(nonatomic,strong) YRSliderView *slider;
@end

@implementation YRNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.frostedViewController.panGestureEnabled = YES;
    self.title = @"附近";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Neighborhood_List"] style:UIBarButtonItemStylePlain target:self action:@selector(changeViewClick:)];
    _isMapView = YES;
    [SharedMapView sharedInstance].delegate = self;
    _mapView = [SharedMapView sharedInstance].mapView;
    _selectView = [[YRMapSelectView alloc] initWithSelectedNum:_isGoOnLearning?2:1];
    _selectView.delegate = self;
    [self.view addSubview:_mapView];
    [self.view addSubview:_selectView];
    [self.view addSubview:self.myLocationBtn];
    [self.view addSubview:self.slider];
    [_mapView addSubview:self.searchBar];
    [self getDataForMap:_isGoOnLearning?2:1];
    if (_isGoOnLearning) {
        [self changeViewClick:nil];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tablewViewReloadData:) name:kNearViewControlerReloadTable object:nil];
    //添加边缘手势
    [self addEdgeGesture];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //清除掉状态字段，防止普通预约也误认为是拼教练
    _isShareOrder = NO;
}

#pragma mark - Private Methods
//收到筛选信息之后的通知处理
-(void)tablewViewReloadData:(NSNotification*)notification{
    //驾校筛选信息
    if (_selectView.selectedBtnNum == NearTableTypeSchool) {
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0",@"sort":_schoolFillterView.sort?:@"0",@"address":(_schoolFillterView.addr && ![_schoolFillterView.addr isEqualToString:@"不限"])?_schoolFillterView.addr:@"",@"key":@""};
        [_schoolData getDataWithParameters:parameters];
    }else{//教练筛选信息
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0",@"sort":_coachFillterView.sort?:@"0",@"address":(_coachFillterView.addr && ![_coachFillterView.addr isEqualToString:@"不限"])?_coachFillterView.addr:@"",@"key":@"",@"kind":_coachFillterView.kind?:@"0"};
        [_coachData getDataWithParameters:parameters];
    }
}
-(void)getDataForMap:(NSInteger) kind{
    NSNumber *timeForMapUpdate = [[NSUserDefaults standardUserDefaults] objectForKey:@"timeForMapUpdate"];
    NSNumber *nowTime = [NSNumber numberWithDouble:[NSDate date].timeIntervalSince1970];
    [RequestData GET:STUDENT_NEARBYPOINT parameters:@{@"kind":[NSNumber numberWithInteger:kind],@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0",@"time":timeForMapUpdate?:@"",@"tkind":_tkind?@"1":@"0"} complete:^(NSDictionary *responseDic) {
        switch (kind) {
            case 1:{
                _schoolForMap = [YRSchoolModel mj_objectArrayWithKeyValuesArray:responseDic];
                [_schoolForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj setCoordinate:CLLocationCoordinate2DMake([[obj lat] doubleValue],[[obj lng] doubleValue])];
                    if ([obj pics].count) {
                        [obj setImaageurl:((YRPictureModel*)([obj pics][0])).url];
                    }
                }];
                NSMutableArray *schools = [YRMapFMDB GetSchools].mutableCopy;
                [schools addObjectsFromArray:_schoolForMap];
                [YRMapFMDB saveObjects:_schoolForMap];
                _schoolForMap = schools.copy;
                [[NSUserDefaults standardUserDefaults] setObject:nowTime forKey:@"timeForMapUpdate"];
                break;
            }
            case 2:{
                _coachForMap = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
                [_coachForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj setCoordinate:CLLocationCoordinate2DMake([[obj lat] doubleValue],[[obj lng] doubleValue])];
                }];
                break;
            }
            case 3:{
                _stuForMap = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
                [_stuForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj setCoordinate:CLLocationCoordinate2DMake([[obj lat] doubleValue],[[obj lng] doubleValue])];
                }];
                break;
            }
            default:
                break;
        }
        [self addAnnotationswithType:kind];
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
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
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"Neighborhood_map"]];
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
        [self.navigationItem.rightBarButtonItem setImage:[UIImage imageNamed:@"Neighborhood_List"]];
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
-(void)myLocationBtnClick:(UIButton*)sender{
    double lat = [KUserLocation.latitude?:0 doubleValue];
    double lng = [KUserLocation.longitude doubleValue];
    if (lat) {
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(lat, lng);
    }
}
-(void)sliderDrag:(UISlider*)sender{
    if (sender.value>50) {
        [sender setValue:100 animated:YES];
        if (_tkind == 0) {
            _tkind = 1;
            [_mapView removeAnnotations:_coachForMap];
            [self getDataForMap:2];
        }
    }else{
        [sender setValue:0 animated:YES];
        if (_tkind == 1) {
            _tkind = 0;
            [_mapView removeAnnotations:_coachForMap];
            [self getDataForMap:2];
        }
    }
}
-(void)addEdgeGesture
{
    UIScreenEdgePanGestureRecognizer *screenEdagePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePanGesture:)];
    [screenEdagePan setEdges:UIRectEdgeLeft];
    [_mapView addGestureRecognizer:screenEdagePan];
}

-(void)screenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    
    [self.frostedViewController panGestureRecognized:recognizer];
    
}
#pragma mark - YRMapSelectViewDelegate
-(void)schoolBtnClick:(UIButton *)sender{
    if (sender.tag == _selectView.selectedBtnNum) {
        return;
    }
    [self removeLastTable];
    _searchBar.hidden = NO;
    self.slider.hidden = YES;
    [_mapView removeAnnotations:_coachForMap];
    [_mapView removeAnnotations:_stuForMap];
    [self getDataForMap:1];
    
    if (!_isMapView) {
        [self.view addSubview:self.schoolTable];
        if (!self.schoolFillterView.hasObserver) {
            [self.schoolFillterView addMyObserver];
        }
        [self.coachFillterView removeMyObserver];
    }
}
-(void)coachBtnClick:(UIButton*)sender{
    if (sender.tag == _selectView.selectedBtnNum) {
        return;
    }
    self.slider.hidden = NO;
    [self removeLastTable];
    _searchBar.hidden = NO;
    [_mapView removeAnnotations:_schoolForMap];
    [_mapView removeAnnotations:_stuForMap];
    [self getDataForMap:2];
    if (!_isMapView) {
        [self.view addSubview:self.coachTable];
        if (!self.coachFillterView.hasObserver) {
            [self.coachFillterView addMyObserver];
        }
        [self.schoolFillterView removeMyObserver];
    }
}
-(void)studentBtnClick:(UIButton*)sender{
    if (sender.tag == _selectView.selectedBtnNum) {
        return;
    }
    [self removeLastTable];
    _searchBar.hidden = YES;
    self.slider.hidden = YES;
    [_mapView removeAnnotations:_schoolForMap];
    [_mapView removeAnnotations:_coachForMap];
    [self getDataForMap:3];
    
    if (!_isMapView) {
        [self.view addSubview:self.studentTable];
    }
}
-(void)removeLastTable{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UITableView class]]){
            [obj removeFromSuperview];
        }
    }];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == NearTableTypeSchool) {
        YRSchoolCelldetailVC *schoolDetail = [[YRSchoolCelldetailVC alloc] init];
        schoolDetail.placeID = [_schoolData.placeArray[indexPath.section][indexPath.row] id];
        [self.navigationController pushViewController:schoolDetail animated:YES];
    }else if(tableView.tag == NearTableTypeCoach){
        YRTeacherDetailController *coachDetail = [[YRTeacherDetailController alloc] init];
        coachDetail.teacherID = [_coachData.coachArray[indexPath.section][indexPath.row] id];
        coachDetail.kind = [_coachData.coachArray[indexPath.section][indexPath.row] kind];
        coachDetail.isShareOrder = _isShareOrder;
        coachDetail.partnerModel = _partnerModel;
        [self.navigationController pushViewController:coachDetail animated:YES];
    }else{
        YRUserDetailController *userDetail = [[YRUserDetailController alloc] init];
        userDetail.userID = [_studentData.stuArray[indexPath.section][indexPath.row] id];
        [self.navigationController pushViewController:userDetail animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if (searchBar.text.length == 0) {
        return;
    }
    NSMutableArray *searchRes = @[].mutableCopy;
    //当前是驾校
    if (_selectView.selectedBtnNum == 1) {
        [_schoolForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([[obj name] containsString:searchBar.text]){
                [searchRes addObject:obj];
            }
        }];
        [_mapView removeAnnotations:_schoolForMap];
    }else{//当前是教练
        [_coachForMap enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([[obj name] containsString:searchBar.text]){
                [searchRes addObject:obj];
            }
        }];
        [_mapView removeAnnotations:_coachForMap];
    }
    [_mapView addAnnotations:searchRes];
    
}
#pragma mark - CallOutViewDelegate
-(void)callOutViewClickedKind:(NSInteger)kind modelID:(NSString*) modelID{
    if (kind == NearTableTypeSchool) {
        YRSchoolCelldetailVC *schoolDetail = [[YRSchoolCelldetailVC alloc] init];
        schoolDetail.placeID = modelID;
        [self.navigationController pushViewController:schoolDetail animated:YES];
    }else if(kind == NearTableTypeCoach){
        YRTeacherDetailController *coachDetail = [[YRTeacherDetailController alloc] init];
        coachDetail.teacherID = modelID;
        coachDetail.kind = 0;//表明教练负责科目二教学或者科目三
        [self.navigationController pushViewController:coachDetail animated:YES];
    }else{
        YRUserDetailController *userDetail = [[YRUserDetailController alloc] init];
        userDetail.userID = modelID;
        [self.navigationController pushViewController:userDetail animated:YES];
    }
}
#pragma mark - Getters
-(UITableView *)schoolTable{
    if (!_schoolTable) {
        _schoolTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight-64)];
        _schoolTable.tableHeaderView = self.schoolFillterView;
        [_schoolTable registerNib:[UINib nibWithNibName:@"YRSchoolTableCell" bundle:nil] forCellReuseIdentifier:schoolCellID];
        _schoolTable.rowHeight = 100;
        _studentTable.tableFooterView = [[UIView alloc]init];
        _schoolData = [[SchoolDataSource alloc]init];
        _schoolData.table = _schoolTable;
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0",@"sort":@"0",@"address":@"",@"key":@""};
        [_schoolData getDataWithParameters:parameters];
        _schoolTable.dataSource = _schoolData;
        _schoolTable.tag = NearTableTypeSchool;
        _schoolTable.delegate = self;
        _schoolTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:_schoolData refreshingAction:@selector(loadMoreData)];
        
    }
    return _schoolTable;
}
-(UITableView *)coachTable{
    if (!_coachTable) {
        _coachTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight-64)];
        _coachTable.tableHeaderView = self.coachFillterView;
        [_coachTable registerNib:[UINib nibWithNibName:@"YRCoachTableCell" bundle:nil] forCellReuseIdentifier:coachCellID];
        _coachTable.rowHeight = 100;
        _coachTable.tableFooterView = [[UIView alloc]init];
        _coachData = [[CoachDataSource alloc] init];
        _coachData.table = _coachTable;
        _coachTable.dataSource = _coachData;
        //106.555023,29.559123
        NSDictionary *parameters = @{@"page":@0,@"lat":KUserLocation.latitude?:@"0",@"lng":KUserLocation.longitude?:@"0",@"sort":@"0",@"address":@"",@"key":@""};
        [_coachData getDataWithParameters:parameters];
        _coachTable.tag = NearTableTypeCoach;
        _coachTable.delegate = self;
        _coachTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:_coachData refreshingAction:@selector(loadMoreData) ];
    }
    return _coachTable;
}
-(UITableView *)studentTable{
    if (!_studentTable) {
        _studentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight-64)];
        [_studentTable registerNib:[UINib nibWithNibName:@"YRStudentTableCell" bundle:nil] forCellReuseIdentifier:studentCellID];
        _studentTable.rowHeight = 100;
        _studentData = [[StudentDataSource alloc] init];
        _studentData.table = _studentTable;
        _studentTable.dataSource = _studentData;
        [_studentData getData];
        _studentTable.tag = NearTableTypeStudent;
        _studentTable.delegate = self;
        _studentTable.tableFooterView = [[UIView alloc]init];
        _studentTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:_studentData refreshingAction:@selector(loadMoreData) ];
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
        _schoolFillterView.itemArrs = @[@[@[@"重庆"],@[@"不限",@"南岸",@"江北",@"渝北",@"渝中",@"北碚",@"巴南",@"沙坪坝"]],
                                        @[@[@"综合排序",@"人气最高",@"距离最近",@"评价最好"]]];
        _schoolFillterView.tag = 1;
    }
    return _schoolFillterView;
}
-(YRFillterBtnView *)coachFillterView{
    if (!_coachFillterView) {
        _coachFillterView = [[YRFillterBtnView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, 44) titleArray:@[@"地区",@"排序方式",@"科二教练"]];
        _coachFillterView.itemArrs = @[@[@[@"重庆"],@[@"不限",@"南岸",@"江北",@"渝北",@"渝中",@"北碚",@"巴南",@"沙坪坝"]],
                                       @[@[@"综合排序",@"人气最高",@"距离最近",@"评价最好"]],@[@[@"科二教练",@"科三教练"]]];
        _coachFillterView.tag = 2;
    }
    return _coachFillterView;
}
-(UIButton *)myLocationBtn{
    if (!_myLocationBtn) {
        _myLocationBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, kScreenHeight - 60, 50, 50)];
        [_myLocationBtn setImage:[UIImage imageNamed:@"Neighborhood_Location"] forState:UIControlStateNormal];
        [_myLocationBtn addTarget:self action:@selector(myLocationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myLocationBtn;
}
-(YRSliderView *)slider{
    if (!_slider) {
        _slider = [[YRSliderView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 70, kScreenWidth, 70)];
        _slider.hidden = YES;
        [_slider.slider addTarget:self action:@selector(sliderDrag:) forControlEvents:UIControlEventTouchUpInside];
        [_slider.slider addTarget:self action:@selector(sliderDrag:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _slider;
}
@end
