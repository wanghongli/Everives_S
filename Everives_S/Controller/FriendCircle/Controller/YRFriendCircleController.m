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
    self.title = @"驾友圈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addWeiboClick:)];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self buildRefreshUI];
    self.tableView.backgroundColor = kCOLOR(241, 241, 241);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getdata];
    
    
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
-(void)getdata
{
    [RequestData GET:WEIBO_GET_LIST parameters:@{@"page":[NSString stringWithFormat:@"%ld",_page]} complete:^(NSDictionary *responseDic) {
        if (_page == 0) {
            [_blogs removeAllObjects];
        }
        NSArray *array = [YRWeibo mj_objectArrayWithKeyValuesArray:(NSArray *)responseDic];
        for (YRWeibo *status in array) {
            YRCircleCellViewModel *statusF = [[YRCircleCellViewModel alloc]init];
            statusF.status = status;
            [_blogs addObject:statusF];
        }
        NSLog(@"%@",_blogs);
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
-(void)addWeiboClick:(UIBarButtonItem *)sender
{
    YRAddWeiboController *addWeiboVC = [[YRAddWeiboController alloc]init];
    [self.navigationController pushViewController:addWeiboVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _blogs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRFriendCircleCell *cell = [YRFriendCircleCell cellWithTableView:tableView];
    YRCircleCellViewModel *statusF = _blogs[indexPath.section];
    cell.statusF = statusF;
    return cell;
}
// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取status模型
    YRCircleCellViewModel *statusF = _blogs[indexPath.section];
    
    return statusF.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerSectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    footerSectionView.backgroundColor = kCOLOR(241, 241, 241);
    return footerSectionView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRCircleDetailController *detialVC = [[YRCircleDetailController alloc]initWithNibName:@"YRCircleDetailController" bundle:nil];
    YRCircleCellViewModel *statusF = _blogs[indexPath.section];
    detialVC.statusF = statusF;
    [self.navigationController pushViewController:detialVC animated:YES];
}


@end
