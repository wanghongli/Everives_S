//
//  YRMenuMessageController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMenuMessageController.h"
#import "MJRefresh/MJRefresh.h"
#import "YRMessageObject.h"
#import "YRMessageViewCell.h"
#import "YRMyFriendsObject.h"
#import "YRYJNavigationController.h"
#import "YRAppointmentDetailController.h"

@interface YRMenuMessageController ()
{
    NSInteger _page;
    NSMutableArray *_arrayMsg;
    NSArray *friendsArray;
}
@end

@implementation YRMenuMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRMessageViewCell" bundle:nil] forCellReuseIdentifier:@"notiCell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self buildRefreshUI];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu)];

    [self getFriend];
}
-(void)getFriend
{
    [RequestData GET:@"/friend/friends" parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        friendsArray = [YRMyFriendsObject mj_objectArrayWithKeyValuesArray:responseDic];
        [self getData];
    } failed:^(NSError *error) {
        
    }];
}
-(void)buildRefreshUI
{
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self getData];
    }];
//    [self.tableView.mj_header beginRefreshing];
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
    [RequestData GET:@"/account/notify" parameters:@{@"page":[NSString stringWithFormat:@"%ld",(long)_page],@"count":@"20"} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        NSArray *arrayMsg = [YRMessageObject mj_objectArrayWithKeyValuesArray:responseDic];
        if (_page) {
            _arrayMsg = (NSMutableArray*)[_arrayMsg arrayByAddingObjectsFromArray:arrayMsg];
        }else{
            _arrayMsg = [NSMutableArray arrayWithArray:arrayMsg];
        }
        if (!_arrayMsg.count) {
            [MBProgressHUD showError:@"暂无数据！！！" toView:self.view];
        }
        
        [self.tableView reloadData];

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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayMsg.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"notiCell";
    YRMessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRMessageViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    YRMessageObject *notiMsg = _arrayMsg[indexPath.row];
    cell.friendsArray = friendsArray;
    cell.messageObj = notiMsg;
    [cell setFriendsStautsChange:^(BOOL btnTag) {
        [self getFriend];
    }];
    if(notiMsg.type == 201){//驾友圈评论
        cell.headImg.image = [UIImage imageNamed:@"Message_BespeakRemainder"];
    }else if (notiMsg.type == 400){//拼教练
        cell.headImg.image = [UIImage imageNamed:@"Message_CoachpoolReminder"];
    }else{
        cell.headImg.image = [UIImage imageNamed:@"Message_AddFriRem"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YRMessageObject *notiMsg = _arrayMsg[indexPath.row];
    if (notiMsg.type ==100 ) {//好友申请
        
    }else if (notiMsg.type == 101){//申请通过
        
    }else if (notiMsg.type == 102){//申请拒绝
        
    }else if (notiMsg.type == 201){//驾友圈评论
        
    }else if (notiMsg.type == 400){//拼教练
        YRAppointmentDetailController *detailVC = [[YRAppointmentDetailController alloc]initWithNibName:@"YRAppointmentDetailController" bundle:nil];
        detailVC.title = @"预约详情";
        detailVC.orderId = [NSString stringWithFormat:@"%li",notiMsg.link];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
