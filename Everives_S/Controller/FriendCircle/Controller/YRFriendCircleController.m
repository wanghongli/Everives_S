//
//  YRFriendCircleController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFriendCircleController.h"
#import "YRAddWeiboController.h"
#import "YRWeibo.h"
#import "MJExtension.h"
#import "MJRefresh/MJRefresh.h"
#import "YRCircleCellViewModel.h"
#import "YRFriendCircleCell.h"
#import "YRCircleDetailController.h"
#import "YRCircleHeadView.h"
#import "YRUserDetailController.h"

@interface YRFriendCircleController ()
{
    NSInteger _page;
    NSMutableArray *_blogs;
}
@end

@implementation YRFriendCircleController

- (void)viewDidLoad {
    [super viewDidLoad];
    _blogs = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self buildRefreshUI];
    self.tableView.backgroundColor = kCOLOR(241, 241, 241);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    YRCircleHeadView *headView = [[YRCircleHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.6*kScreenWidth)];
    self.tableView.tableHeaderView = headView;
    if (!self.userStatus) {
        [headView setUserMsgWithName:KUserManager.name gender:[KUserManager.gender boolValue] sign:KUserManager.sign];
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"SNS_AddContent"] highImage:[UIImage imageNamed:@"SNS_AddContent"] target:self action:@selector(addWeiboClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu_icon"] highImage:[UIImage imageNamed:@"menu_icon"] target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [headView setUserMsgWithName:self.userStatus.name gender:[self.userStatus.gender boolValue] sign:self.userStatus.sign];
    }
    headView.image=[UIImage imageNamed:@"background_1"];
    
    [self getdata];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.refreshMsg) {
        self.refreshMsg = nil;
        _page = 0;
        [self getdata];
    }
    
    self.frostedViewController.panGestureEnabled = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.frostedViewController.panGestureEnabled = NO;
}
-(void)buildRefreshUI
{
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self getdata];
    }];
    [self.tableView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self getdata];
    }];
}
#pragma mark - 获取数据源
-(void)getdata
{
    NSString *urlString;
    if (self.userStatus) {
        urlString = [NSString stringWithFormat:@"%@%@",WEIBO_GET_OTHER,self.userStatus.id];
    }else
        urlString = WEIBO_GET_LIST;
    [RequestData GET:urlString parameters:@{@"page":[NSString stringWithFormat:@"%ld",_page]} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        if (_page == 0) {
            [_blogs removeAllObjects];
        }
        NSArray *array = [YRWeibo mj_objectArrayWithKeyValuesArray:(NSArray *)responseDic];
        for (YRWeibo *status in array) {
            YRCircleCellViewModel *statusF = [[YRCircleCellViewModel alloc]init];
            statusF.status = status;
            [_blogs addObject:statusF];
        }
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    } failed:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark - 添加微博
-(void)addWeiboClick:(UIBarButtonItem *)sender
{
    YRAddWeiboController *addWeiboVC = [[YRAddWeiboController alloc]init];
    [self.navigationController pushViewController:addWeiboVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UITableViewDataDelegate
//分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _blogs.count;
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//uitableviewcell定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRFriendCircleCell *cell = [YRFriendCircleCell cellWithTableView:tableView];
    YRCircleCellViewModel *statusF = _blogs[indexPath.section];
    cell.statusF = statusF;
    cell.lineBool = NO;
    [cell setCommentOrAttentClickBlock:^(NSInteger zan) {//点赞和消息
        if (zan == 1){//消息
            return;
        }
        if ([statusF.status.praised boolValue]) {//取消点赞
            statusF.status.praise = [NSString stringWithFormat:@"%ld",[statusF.status.praise integerValue]-1];
        }else//点赞
            statusF.status.praise = [NSString stringWithFormat:@"%ld",[statusF.status.praise integerValue]+1];
        //更新数据源
        statusF.status.praised = [NSString stringWithFormat:@"%d",![statusF.status.praised boolValue]];
        [_blogs replaceObjectAtIndex:indexPath.section withObject:statusF];
        [self.tableView reloadData];
    }];
    //点击头像事件
    [cell setIconClickBlock:^(BOOL userBool) {
        if (self.userStatus) {
            return;
        }
        YRUserDetailController *userVC = [[YRUserDetailController alloc]init];
        if (!userBool) {//用户自己
            userVC.userID = statusF.status.uid;
        }
        [self.navigationController pushViewController:userVC animated:YES];
    }];
    return cell;
}
// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取status模型
    YRCircleCellViewModel *statusF = _blogs[indexPath.section];
    
    return statusF.cellHeight;
}
//footer的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
//header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 0.1;
}
//footerview
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    footerSectionView.backgroundColor = kCOLOR(250, 250, 250);
    return footerSectionView;
}
//cell选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRCircleDetailController *detialVC = [[YRCircleDetailController alloc]initWithNibName:@"YRCircleDetailController" bundle:nil];
    YRCircleCellViewModel *statusF = _blogs[indexPath.section];
    detialVC.statusF = statusF;
    [self.navigationController pushViewController:detialVC animated:YES];
}


@end
