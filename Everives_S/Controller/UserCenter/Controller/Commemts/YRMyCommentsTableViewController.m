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
    [self getData];
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
        }
        [self.tableView reloadData];
    } failed:^(NSError *error) {
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
