//
//  YRTeacherCommentDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherCommentDetailController.h"
#import "YRTeacherCommentDetailHeadView.h"
#import "YRTeacherCommentDetailObj.h"
#import "YRLearnOrderDetailInfo.h"
#import "YRTeacherCommentDownView.h"
#import "YRSharedDateArray.h"
@interface YRTeacherCommentDetailController ()
{
    NSArray *_titleArray;
    NSArray *_menuArray;
    NSMutableArray *_totalMenu;
}
@property (nonatomic, strong) YRTeacherCommentDetailHeadView *commentDetailHeadView;
@property (nonatomic, strong) YRTeacherCommentDetailObj *detailObj;
@property (nonatomic, strong) YRTeacherCommentDownView *downView;
@end

@implementation YRTeacherCommentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价详情";
    _titleArray = @[@"预约时间",@"学车时段",@"训练场地准",@"预约费用"];
    _menuArray = @[@"2016年3月4日 星期五",@"14:00-16:00&17:00-18:00",@"玉祥驾校南山区",@"￥450"];
    self.tableView.tableHeaderView = self.commentDetailHeadView;
    
    [self getData];
}
-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [RequestData GET:[NSString stringWithFormat:@"/order/comment/%ld",self.orderID] parameters:nil complete:^(NSDictionary *responseDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        MyLog(@"%@",responseDic);
        self.detailObj = [YRTeacherCommentDetailObj mj_objectWithKeyValues:responseDic];
        self.commentDetailHeadView.detailObj = self.detailObj;
        
        _totalMenu = [NSMutableArray array];
        for (int i = 0 ; i<self.detailObj.info.count; i++) {
            YRLearnOrderDetailInfo *detailInfo = self.detailObj.info[i];
            NSString *orderTime = [YRPublicMethod getDateAndWeekWith:detailInfo.date];;
            NSString *string = [YRSharedDateArray sharedInstance].timeArrayAllFact[detailInfo.time];
            NSString *price = [NSString stringWithFormat:@"￥%ld",detailInfo.price];
            _menuArray = @[orderTime,string,detailInfo.place,price];
            [_totalMenu addObject:_menuArray];
        }
        [self.tableView reloadData];
        self.downView = [[YRTeacherCommentDownView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [YRTeacherCommentDownView getTeacherCommentDownViewObj:self.detailObj])];
        self.downView.detailObj = self.detailObj;
        self.tableView.tableFooterView = self.downView;
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _totalMenu.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = kCOLOR(60, 63, 62);
    NSArray *array = _totalMenu[indexPath.section];
    cell.detailTextLabel.text = array[indexPath.row];
    cell.detailTextLabel.textColor = kCOLOR(60, 63, 62);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.detailObj.info.count-1) {
        return 2;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(YRTeacherCommentDetailHeadView *)commentDetailHeadView
{
    if (_commentDetailHeadView == nil) {
        _commentDetailHeadView = [[YRTeacherCommentDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.43)];
        [self.view addSubview:_commentDetailHeadView];
    }
    return _commentDetailHeadView;
}

//-(YRTeacherCommentDownView *)downView
//{
//    if (_downView == nil) {
//        _downView = [[YRTeacherCommentDownView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
//        _downView.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _downView;
//}

@end
