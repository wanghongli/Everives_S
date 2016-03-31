//
//  YRYJSecondClassController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/18.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJSecondClassController.h"
#import "YRLearnSecondCell.h"
#import "YRAppointmentDetailController.h"
#import "YRLearnNoMsgView.h"//没认证界面
#import "YRCertificationController.h" //信息认证
#import "YRTeacherOrder.h"
#import "UIViewController+YRCommonController.h"
@interface YRYJSecondClassController ()<UITableViewDelegate,UITableViewDataSource,YRLearnNoMsgViewDelegate>
{
    NSArray *msgArray;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayTable;
@property (nonatomic, strong) UILabel *topView;
@property (nonatomic, strong) UIView *downView;
@property (nonatomic, strong) UIButton *goOnBtn;
@property (nonatomic, strong) YRLearnNoMsgView *noMsgView;
@end

@implementation YRYJSecondClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!KUserManager.id) {
        [self goToLoginVC];
        return;
    }else{
        [self buildUI];
    }
    
}

-(void)buildUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64-48-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRLearnSecondCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    _topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _topView.text = @"你最近的科目二考试安排";
    _topView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = _topView;
    
    _downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth, 44)];
    _downView.backgroundColor = kCOLOR(246, 247, 248);
    _goOnBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 4, kScreenWidth-40, 36)];
    [_goOnBtn setTitle:@"继续安排学车计划" forState:UIControlStateNormal];
    [_goOnBtn setTitleColor:kCOLOR(51, 51, 51) forState:UIControlStateNormal];
    [_downView addSubview:_goOnBtn];
    _goOnBtn.layer.masksToBounds = YES;
    _goOnBtn.layer.cornerRadius = _goOnBtn.height/2;
    _goOnBtn.layer.borderWidth = 1;
    _goOnBtn.layer.borderColor = kCOLOR(51, 51, 51).CGColor;
    [_goOnBtn addTarget:self action:@selector(goOnLearnCar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downView];
    [self.view bringSubviewToFront:_downView];
    //无数据的时候展示
//    [self.view bringSubviewToFront:self.noMsgView];
    //获取数据
    [self getData];
}
-(void)getData
{
    
    [RequestData GET:STUDENT_ORDER parameters:@{@"page":@"0"} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        msgArray = [YRTeacherOrder mj_objectArrayWithKeyValuesArray:responseDic];
        if (msgArray.count) {
            [self.tableView reloadData];
        }else
            [MBProgressHUD showError:@"暂无数据" toView:GET_WINDOW];
    } failed:^(NSError *error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return msgArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    YRLearnSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRLearnSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.testNum = indexPath.section;
//    cell.timeString = @"14:00-16:00";
    YRTeacherOrder *teacherOrder = msgArray[indexPath.row];
    cell.teacherOrder = teacherOrder;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRAppointmentDetailController *detailVC = [[YRAppointmentDetailController alloc]initWithNibName:@"YRAppointmentDetailController" bundle:nil];
    detailVC.title = @"预约详情";
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - YRLearnNoMsgViewDelegate
-(void)learnNoMsgViewAttestationClick
{
    MyLog(@"%s",__func__);
    YRCertificationController *certificationVC = [[YRCertificationController alloc]init];
    [self.navigationController pushViewController:certificationVC animated:YES];
}
#pragma mark - 继续安排学车计划
-(void)goOnLearnCar
{
    MyLog(@"%s",__func__);
}
-(YRLearnNoMsgView *)noMsgView
{
    if (!_noMsgView) {
        
        _noMsgView = [[YRLearnNoMsgView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.tableView.height)];
        _noMsgView.delegate = self;
        [self.view addSubview:_noMsgView];
    }
    return _noMsgView;
}

@end
