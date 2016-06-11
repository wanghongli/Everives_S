//
//  YRYJThirdClassController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/18.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJThirdClassController.h"
#import "YRLearnSecondCell.h"
#import "YRAppointmentDetailController.h"
#import "YRLearnNoMsgView.h"//没认证界面
#import "YRFriendCircleController.h"
#import "YRTeacherOrder.h"
#import "UIViewController+YRCommonController.h"
#import "YRYJNavigationController.h"
#import "REFrostedViewController.h"
#import "YRNearViewController.h"
#import "YRUserCertificationController.h"
@interface YRYJThirdClassController ()<UITableViewDelegate,UITableViewDataSource,YRLearnNoMsgViewDelegate>
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

@implementation YRYJThirdClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!KUserManager.id) {
        [self goToLoginVC];
        return;
    }else{
        [self buildUI];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (KUserManager.status == 0) {//未提交或正在审核
        if (KUserManager.peopleId.length) {//正在审核
            [self showMsgWithMst:@"您的信息正在审核当中" withHidden:NO];
        }else{//未提交
            [self showMsgWithMst:@"抱歉，您还未进行信息认证" withHidden:NO];
        }
    }else if (KUserManager.status == 1){//审核通过
        //获取数据
        [self getData];
    }else if (KUserManager.status == 2){//审核失败
        [self showMsgWithMst:@"审核失败" withHidden:NO];
    }
}
-(void)showMsgWithMst:(NSString *)msg withHidden:(BOOL)hidden
{
    self.noMsgView.btnTitle = msg;
    self.noMsgView.hidden = hidden;
    if (hidden) {
        return;
    }
    //无数据的时候展示
    [self.view bringSubviewToFront:self.noMsgView];
}
-(void)buildUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64-48-44)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRLearnSecondCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    
    _topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _topView.text = @"你最近的科目三考试安排";
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
    
    //获取数据
    [self getData];
}
-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:GET_WINDOW];
    [RequestData GET:STUDENT_ORDER parameters:@{@"page":@"0",@"kind":@"1"} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
        msgArray = [YRTeacherOrder mj_objectArrayWithKeyValuesArray:responseDic];
        if (msgArray.count) {
            [self.tableView reloadData];
            self.noMsgView.hidden = YES;
        }else{
            //            [MBProgressHUD showError:@"暂无数据" toView:GET_WINDOW];
            self.noMsgView.btnTitle = @"安排学车计划";
            self.noMsgView.hidden = NO;
            //无数据的时候展示
            [self.view bringSubviewToFront:self.noMsgView];
        }
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
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
    detailVC.orderId = [msgArray[indexPath.row] id];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - YRLearnNoMsgViewDelegate
-(void)learnNoMsgViewAttestationClickTag:(NSInteger)btnTag
{
    MyLog(@"%s",__func__);
    if (btnTag == 0) {//审核中
        YRFriendCircleController *nearViewController = [[YRFriendCircleController alloc] init];
        nearViewController.title = @"驾友圈";
        YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:nearViewController];
        self.frostedViewController.contentViewController = navigationController;
    }else if (btnTag == 1){//未审核
        YRUserCertificationController *certificationVC = [[YRUserCertificationController alloc]init];
        [self.navigationController pushViewController:certificationVC animated:YES];
    }else{//失败
        YRUserCertificationController *certificationVC = [[YRUserCertificationController alloc]init];
        [self.navigationController pushViewController:certificationVC animated:YES];
    }
}

#pragma mark - 继续安排学车计划
-(void)goOnLearnCar
{
    YRNearViewController *nearViewController = [[YRNearViewController alloc] init];
    nearViewController.isGoOnLearning = YES;
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:nearViewController];
    self.frostedViewController.contentViewController = navigationController;
}
-(YRLearnNoMsgView *)noMsgView
{
    if (!_noMsgView) {
        
        _noMsgView = [[YRLearnNoMsgView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64-48)];
        _noMsgView.delegate = self;
        [self.view addSubview:_noMsgView];
    }
    return _noMsgView;
}
@end
