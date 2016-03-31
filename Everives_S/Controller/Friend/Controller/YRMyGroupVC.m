//
//  YRMyGroupVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyGroupVC.h"
#import "YRSearchFriendCell.h"
#import "YRGroupModel.h"
#import "YRChatViewController.h"
static NSString *groupCellID = @"groupCellID";

@interface YRMyGroupVC (){
    NSArray *_groups;
}

@end

@implementation YRMyGroupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"群聊";
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 60;
    [self.tableView registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:groupCellID];
    [self getData];
    
}

-(void)getData{
    [RequestData GET:GROUP_GROUP parameters:nil complete:^(NSDictionary *responseDic) {
        _groups = [YRGroupModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groups.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:groupCellID forIndexPath:indexPath];
    NSString *avatar = [_groups[indexPath.row] avatar];
    NSString *name = [_groups[indexPath.row] name];
    [cell configureCellWithAvatar:avatar name:name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YRChatViewController *groupChat = [[YRChatViewController alloc]init];
    groupChat.conversationType = ConversationType_GROUP;
    groupChat.targetId = [_groups[indexPath.row] id];
    groupChat.title = [_groups[indexPath.row] name];
    //显示聊天会话界面
    [self.navigationController pushViewController:groupChat animated:YES];
}



@end
