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
#import "YRCoachCellDetailVC.h"
#import "YRFillterBtnView.h"
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
    SchoolDataSource *_schoolData;
    CoachDataSource *_coachData;
    StudentDataSource *_studentData;
    BOOL _isMapView;
    NSMutableArray *_schoolModels;
}
@property(nonatomic,strong) UITableView *schoolTable;
@property(nonatomic,strong) UITableView *coachTable;
@property(nonatomic,strong) UITableView *studentTable;
@property(nonatomic,strong) UISearchBar *searchBar;
@end

@implementation YRNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(changeViewClick:)];
    _isMapView = YES;
    _schoolModels = @[].mutableCopy;
    _mapView = [SharedMapView sharedInstance].mapView;
    _selectView = [[YRMapSelectView alloc] init];
    _selectView.delegate = self;
    [self.view addSubview:_mapView];
    [self.view addSubview:_selectView];
    [_mapView addSubview:self.searchBar];
    [self addAnnotations];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
-(void) addAnnotations{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    //106.483097,29.607267
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(29.607267, 106.483097);
    pointAnnotation.title = @"金科十年城";
    pointAnnotation.subtitle = @"王二狗烧饼斜对面";
    [_schoolModels addObject:pointAnnotation];
    [_mapView addAnnotation:pointAnnotation];
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
    [self removeLastTable];
    [_mapView addSubview:self.searchBar];
    NSLog(@"1");
}
-(void)coachBtnClick:(UIButton*)sender{
    [self removeLastTable];
    [_mapView removeAnnotations:_schoolModels.copy];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    //106.535454,29.613983
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(29.613983, 106.535454);
    pointAnnotation.title = @"天上人间";
    pointAnnotation.subtitle = @"我们是正规洗脚城";
    [_mapView addAnnotation:pointAnnotation];
    NSLog(@"2");
}
-(void)studentBtnClick:(UIButton*)sender{
    [self removeLastTable];
    [self.searchBar removeFromSuperview];
    NSLog(@"3");
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
        [self.navigationController pushViewController:[[YRSchoolCelldetailVC alloc] init] animated:YES];
    }else if(tableView.tag == NearTableTypeCoach){
        [self.navigationController pushViewController:[[YRCoachCellDetailVC alloc] init] animated:YES];
    }
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
#pragma mark - Getters
-(UITableView *)schoolTable{
    if (!_schoolTable) {
        _schoolTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight)];
        [_schoolTable registerNib:[UINib nibWithNibName:@"YRSchoolTableCell" bundle:nil] forCellReuseIdentifier:schoolCellID];
        _schoolTable.rowHeight = 100;
        _schoolData = [[SchoolDataSource alloc]init];
        _schoolData.table = _schoolTable;
        _schoolTable.dataSource = _schoolData;
        [_schoolData getData];
        _schoolTable.tag = NearTableTypeSchool;
        _schoolTable.delegate = self;
        _schoolTable.tableHeaderView = [[YRFillterBtnView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, 44) titleArray:@[@"地区",@"排序方式"]];
        _schoolTable.tableFooterView = [[UIView alloc]init];
    }
    return _schoolTable;
}
-(UITableView *)coachTable{
    if (!_coachTable) {
        _coachTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight)];
        [_coachTable registerNib:[UINib nibWithNibName:@"YRCoachTableCell" bundle:nil] forCellReuseIdentifier:coachCellID];
        _coachTable.rowHeight = 100;
        _coachData = [[CoachDataSource alloc] init];
        _coachData.table = _coachTable;
        _coachTable.dataSource = _coachData;
        [_coachData getData];
        _coachTable.tag = NearTableTypeCoach;
        _coachTable.delegate = self;
        _coachTable.tableFooterView = [[UIView alloc]init];
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

@end
