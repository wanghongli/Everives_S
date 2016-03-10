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
static NSString *schoolCellID = @"YRSchoolTableCellID";
@interface YRNearViewController ()<YRMapSelectViewDelegate>{
    MAMapView *_mapView;
    YRMapSelectView *_selectView;
    SchoolDataSource *_schoolData;
    BOOL _isMapView;
}
@property(nonatomic,strong) UITableView *schoolTable;
@property(nonatomic,strong) UITableView *coachTable;
@property(nonatomic,strong) UITableView *studentTable;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"1");
}
-(void)coachBtnClick:(UIButton*)sender{
    NSLog(@"2");
}
-(void)studentBtnClick:(UIButton*)sender{
    NSLog(@"3");
}
#pragma mark -Getters
-(UITableView *)schoolTable{
    if (!_schoolTable) {
        _schoolTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kScreenWidth, kScreenHeight)];
        [_schoolTable registerNib:[UINib nibWithNibName:@"YRSchoolTableCell" bundle:nil] forCellReuseIdentifier:schoolCellID];
        _schoolTable.rowHeight = 100;
        _schoolData = [[SchoolDataSource alloc]init];
        _schoolTable.dataSource = _schoolData;
    }
    return _schoolTable;
}
-(UITableView *)coachTable{
    return _coachTable;
}
-(UITableView *)studentTable{
    return _studentTable;
}


@end
