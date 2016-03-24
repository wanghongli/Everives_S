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
@interface YRYJSecondClassController ()<UITableViewDelegate,UITableViewDataSource,YRLearnNoMsgViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrayTable;
@property (nonatomic, strong) UILabel *topView;

@property (nonatomic, strong) YRLearnNoMsgView *noMsgView;
@end

@implementation YRYJSecondClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    [self buildUI];
}
-(void)buildUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRLearnSecondCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _topView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _topView.text = @"你最近的科目二考试安排";
    _topView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = _topView;
    
    [self.view bringSubviewToFront:self.noMsgView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
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
    cell.testNum = indexPath.section;
    cell.timeString = @"14:00-16:00";
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
