//
//  YRTeacherAllCommentControllerController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/14.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherAllCommentControllerController.h"
#import "MJRefresh/MJRefresh.h"
#import "YRTeacherCommentObj.h"
#import "YRTeacherCommentCell.h"
@interface YRTeacherAllCommentControllerController ()
{
    NSInteger _page;
}
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation YRTeacherAllCommentControllerController
-(NSMutableArray *)commentArray
{
    if (_commentArray==nil) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评价";
//    [self getData];
    self.tableView.tableFooterView = [[UIView alloc]init];
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
    [RequestData GET:[NSString stringWithFormat:@"/account/teaComment/%ld",self.teacherID] parameters:@{@"page":[NSString stringWithFormat:@"%ld",_page]} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSArray *array = [YRTeacherCommentObj mj_objectArrayWithKeyValuesArray:responseDic];
        if (_page) {
            [self.commentArray addObjectsFromArray:array];
        }else
            self.commentArray = [NSMutableArray arrayWithArray:array];
        [self.tableView reloadData];
        if (!self.commentArray.count) {
            [MBProgressHUD showError:@"暂无评价数据!" toView:self.view];
        }
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failed:^(NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    YRTeacherCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRTeacherCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    // Configure the cell...
    YRTeacherCommentObj *commentObj = self.commentArray[indexPath.row];
    cell.teacherCommentObj = commentObj;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRTeacherCommentObj *commentObj = self.commentArray[indexPath.row];

    return [YRTeacherCommentCell getTeacherCommentCellHeightWith:commentObj];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
