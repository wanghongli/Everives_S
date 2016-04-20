//
//  YRMyCommentsVCTableViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyCommentsTableViewController.h"
#import "YRTeacherCommentDetailController.h"
#import "YRMyCommentTableViewCell.h"
#import "YRMyCommentObj.h"
#import "MJRefresh/MJRefresh.h"

@interface YRMyCommentsTableViewController ()
{
    NSMutableArray *_commentArray;
    NSInteger _page;
}
@end

static NSString *cellID =@"YRMyCommentCellTableViewCellID";
@implementation YRMyCommentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评价";
     self.clearsSelectionOnViewWillAppear = NO;
    _page = 0;
    self.tableView.rowHeight = 100;
    self.tableView.tableFooterView = [[UIView alloc]init];
//    [self getData];
    [self buildRefreshUI];
}
-(void)buildRefreshUI
{
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self getData];
    }];
    [self.tableView.mj_header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self getData];
    }];
}

-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [RequestData GET:STUDENT_GET_COMMENT_LIST parameters:@{@"page":[NSString stringWithFormat:@"%ld",_page]} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSArray *array = [YRMyCommentObj mj_objectArrayWithKeyValuesArray:responseDic];
        if (_page == 0) {
            _commentArray = [NSMutableArray arrayWithArray:array];
        }else{
            [_commentArray addObjectsFromArray:array];
        }
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _commentArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    YRMyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YRMyCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    YRMyCommentObj *commentObj = _commentArray[indexPath.row];
    cell.commentObj = commentObj;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRMyCommentObj *commentObj = _commentArray[indexPath.row];
    YRTeacherCommentDetailController *detailVC = [[YRTeacherCommentDetailController alloc]init];
    detailVC.orderID = commentObj.id;
    [self.navigationController pushViewController:detailVC animated:YES];
//    [self.navigationController pushViewController:[[YRCommentDetailVC alloc] init] animated:YES];
}

@end
