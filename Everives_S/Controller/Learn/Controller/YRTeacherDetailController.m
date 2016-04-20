//
//  YRTeacherDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherDetailController.h"
#import "YRTeacherDetailCell.h"
#import "YRTeacherCommentCell.h"
#import "YRTeacherPlaceCell.h"
#import "YRTeacherImageCell.h"
#import "YRTeacherHeadView.h"
#import "YRTeacherSectionSecoView.h"
#import "YRReservationDateVC.h"
#import "YRTeacherDownView.h"
#import "YRTeacherDetailObject.h"
#import "YRSchoolModel.h"
#import <MJExtension.h>
#import "YRTeacherDetailObj.h"
#import "YRTeacherPlaceObj.h"
#import "YRTeacherPicsObj.h"
#import "YRTeacherAllCommentControllerController.h"
#import "YRSchoolCelldetailVC.h"
#import "YRTeacherAllPicsController.h"
#import "MJRefresh/MJRefresh.h"

@interface YRTeacherDetailController () <UITableViewDelegate,UITableViewDataSource,YRTeacherDownViewDelegate>
{
    YRTeacherDetailObject *_teacherObj;
}
@property (nonatomic, strong) YRTeacherDetailObj *teacherDetail;
@property (nonatomic, strong) NSArray *placeArray;
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, strong) YRTeacherHeadView *headView;

@property (nonatomic, strong) YRTeacherDownView *downView;
@end

@implementation YRTeacherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教练详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //获取数据
    [self getData];
}
#pragma mark - 获取数据
-(void)getData
{
    //获取教练详情
    NSString *urlString = [NSString stringWithFormat:@"%@%@",USER_TEACHER_DETAIL,self.teacherID];
    [RequestData GET:urlString parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        
        self.teacherDetail = [YRTeacherDetailObj mj_objectWithKeyValues:responseDic];
//        _teacherObj = [YRTeacherDetailObject mj_objectWithKeyValues:responseDic];

        _headView = [[YRTeacherHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
        _headView.teacherObj = self.teacherDetail;
        self.tableView.tableHeaderView = _headView;
        self.tableView.tableFooterView = [[UIView alloc]init];
        
        _downView = [[YRTeacherDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, 44)];
        _downView.delegate = self;
        [self.view addSubview:_downView];

    } failed:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numbRow;
    if (section == 0) {
        numbRow = 1;
    }else if (section == 1){
        if (_teacherDetail.comment) {
            numbRow = 1;
        }else
            numbRow = 0;
    }else if (section == 2) {
        numbRow = self.teacherDetail.place.count;
    }else{
        if (_teacherDetail.pics.count) {
            numbRow = 1;
        }else{
            numbRow = 0;
        }
    }
    return numbRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YRTeacherDetailCell *cell = [YRTeacherDetailCell cellWithTableView:tableView];
        cell.introduce = self.teacherDetail.intro;
        return cell;
    }else if (indexPath.section == 1){
        YRTeacherCommentCell *cell = [YRTeacherCommentCell cellWithTableView:tableView];
        cell.teacherCommentObj = _teacherDetail.comment[0];
        return cell;
    }else if (indexPath.section == 2){
        YRTeacherPlaceCell *cell = [YRTeacherPlaceCell cellWithTableView:tableView];
        YRTeacherPlaceObj *placeObj = _teacherDetail.place[indexPath.row];
        [cell teacherPlaceGetSchoolName:placeObj.name address:@""];
        return cell;
    }else{
        YRTeacherImageCell *cell = [YRTeacherImageCell cellWithTableView:tableView];
        cell.imgArray = self.teacherDetail.pics;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [YRTeacherDetailCell getTeacherDetailCellHeightWith:@"态度温和，不骂学员，长得帅。首次通过率为92%，有多年教学经验可以放心。"];
    }else if (indexPath.section == 1){
        return [YRTeacherCommentCell getTeacherCommentCellHeightWith:_teacherDetail.comment[0]];

    }else if (indexPath.section == 2){
        return 44;
    }else{
        return (kScreenWidth - 40)/3;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *view = [[UIView alloc]init];
        return view;
    }else{
        YRTeacherSectionSecoView *sectionView = [[YRTeacherSectionSecoView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        if (section == 1) {
            sectionView.titleString = @"学员评价";
        }else if(section == 2){
            sectionView.titleString = @"练车场地";
        }else{
            sectionView.titleString = @"场地和车型照片";
        }
        [sectionView setMoreCommentOrPicClickBlock:^(NSString *titleString) {
            MyLog(@"%@",titleString);
            if ([titleString isEqualToString:@"全部评论"]) {
                YRTeacherAllCommentControllerController *allComment = [[YRTeacherAllCommentControllerController alloc]init];
                allComment.teacherID = [self.teacherID integerValue];
                [self.navigationController pushViewController:allComment animated:YES];
            }else if ([titleString isEqualToString:@"全部照片"]){
                YRTeacherAllPicsController *allPicsVC = [[YRTeacherAllPicsController alloc]init];
                allPicsVC.teacherID = [self.teacherID integerValue];
                [self.navigationController pushViewController:allPicsVC animated:YES];
            }
        }];
        return sectionView;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.1;
    }else
        return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        YRSchoolCelldetailVC *schoolVC = [[YRSchoolCelldetailVC alloc]init];
        YRTeacherPlaceObj *placeObj = _teacherDetail.place[indexPath.row];
        schoolVC.placeID = [NSString stringWithFormat:@"%ld",placeObj.id];
        [self.navigationController pushViewController:schoolVC animated:YES];
    }
}

#pragma mark - teacherDownView代理
-(void)teacherDownViewBtnClick:(NSInteger)btnTag
{
    if (btnTag == 1) {//关注
        [RequestData POST:@"/student/teacher" parameters:@{@"id":self.teacherID} complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
            [MBProgressHUD showSuccess:@"关注成功" toView:self.view];
        } failed:^(NSError *error) {
            
        }];
    }else{//预约
        YRReservationDateVC *chooseDateVC = [[YRReservationDateVC alloc] init];
        chooseDateVC.isShareOrder = _isShareOrder;
        self.teacherDetail.kind = [_kind integerValue];
        chooseDateVC.coachModel = self.teacherDetail;
        chooseDateVC.partnerModel = _partnerModel;
        [self.navigationController pushViewController:chooseDateVC animated:YES];
    }
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



@end
