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

#import "YRTeacherDownView.h"
@interface YRTeacherDetailController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, strong) YRTeacherHeadView *headView;

@property (nonatomic, strong) YRTeacherDownView *downView;
@end

@implementation YRTeacherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"教练详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _headView = [[YRTeacherHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    self.tableView.tableHeaderView = _headView;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _downView = [[YRTeacherDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, 44)];
    [self.view addSubview:_downView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numbRow;
    if (section == 2) {
        numbRow = 4;
    }else
        numbRow = 1;
    return numbRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YRTeacherDetailCell *cell = [YRTeacherDetailCell cellWithTableView:tableView];
        cell.introduce = @"态度温和，不骂学员，长得帅。首次通过率为92%，有多年教学经验可以放心。";
        return cell;
    }else if (indexPath.section == 1){
        YRTeacherCommentCell *cell = [YRTeacherCommentCell cellWithTableView:tableView];
        cell.introduce = @"态度温和，不骂学员，长得帅。首次通过率为92%，有多年教学经验可以放心。";
        return cell;
    }else if (indexPath.section == 2){
        YRTeacherPlaceCell *cell = [YRTeacherPlaceCell cellWithTableView:tableView];
        [cell teacherPlaceGetSchoolName:@"希望小学驾校" address:@"南岸/黄角丫"];
        return cell;
    }else{
        YRTeacherImageCell *cell = [YRTeacherImageCell cellWithTableView:tableView];
        cell.imgArray = nil;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [YRTeacherDetailCell getTeacherDetailCellHeightWith:@"态度温和，不骂学员，长得帅。首次通过率为92%，有多年教学经验可以放心。"];
    }else if (indexPath.section == 1){
        return [YRTeacherCommentCell getTeacherCommentCellHeightWith:@"态度温和，不骂学员，长得帅。首次通过率为92%，有多年教学经验可以放心。"];
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
            sectionView.titleString = @"学员评价(12)";
        }else if(section == 2){
            sectionView.titleString = @"练车场地";
        }else{
            sectionView.titleString = @"场地和车型照片";
        }
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
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-24)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
