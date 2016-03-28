//
//  YRContactVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRContactVC.h"
#import "YRSearchFriendCell.h"
#import "ChineseString.h"
#import "YRUserDetailController.h"
#import "YRMyCoachVC.h"
#import "RequestData.h"
#import "YRChatViewController.h"
static NSString *cellID = @"cellID";

@interface YRContactVC(){
    NSArray *_ret;//服务器返回的好友列表
    NSMutableArray *_selectedArray;
}

@property(nonatomic,strong)UIButton *myGroup;
@property(nonatomic,strong)UIButton *myCoach;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NSMutableArray *indexArray;//去重后的首字母，右侧导航
@property(nonatomic,strong)NSMutableArray *letterResultArr;//按照首字母排序后的集合
@property(nonatomic,strong)YRMyCoachVC *myCoachVC;

@end

@implementation YRContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedArray = @[].mutableCopy;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 60;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:cellID];
    if (_isAllowSelected) {
        self.tableView.editing = YES;
        self.tableView.allowsMultipleSelectionDuringEditing = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(completeBtnClickWhenEditing)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    [self getContacts];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_myCoachVC.selectedCoachName) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
-(void)getContacts{
    [RequestData GET:STUDENT_FRIENDS parameters:nil complete:^(NSDictionary *responseDic) {
        _ret = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        if (_ret) {
            self.indexArray = [ChineseString IndexArray:_ret];
            self.letterResultArr = [ChineseString LetterSortArray:_ret];
            [self.tableView  reloadData];
        }
    } failed:^(NSError *error) {
        
    }];
}

-(void)myGroupBtnClick:(UIButton*)sender{
    
}
-(void)myCoachBtnClick:(UIButton*)sender{
    _myCoachVC = [[YRMyCoachVC alloc]init];
    if (_isAllowSelected) {
        _myCoachVC.isAllowSelected = YES;
    }
    [self.navigationController pushViewController:_myCoachVC animated:YES];
}
-(void)completeBtnClickWhenEditing{
    NSMutableArray *selectedUserIds = @[].mutableCopy;
    [_selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *userID = [[[self.letterResultArr objectAtIndex:[obj section]]objectAtIndex:[obj row]] id];
        [selectedUserIds addObject:@{@"id":userID}];
    }];
    NSInteger selectedNum = _selectedArray.count+_myCoachVC.selectedCoachIDArray.count;
    if (selectedNum == 1) {
        YRChatViewController *Chat = [[YRChatViewController alloc]init];
        Chat.conversationType = ConversationType_PRIVATE;
        Chat.targetId = selectedUserIds.count?[NSString stringWithFormat:@"stu%@",selectedUserIds[0]]:[NSString stringWithFormat:@"tea%@",_myCoachVC.selectedCoachIDArray[0]];
        Chat.title = _myCoachVC.selectedCoachName?:[[[self.letterResultArr objectAtIndex:[_selectedArray[0] section]] objectAtIndex:[_selectedArray[0] row]] name];
        //显示聊天会话界面
        [self.navigationController pushViewController:Chat animated:YES];
    }else{
        NSDictionary *dic = @{@"tea":selectedUserIds,@"stu":_myCoachVC.selectedCoachIDArray?:@[]};
        [RequestData POST:GROUP_GROUP parameters:@{@"data":[dic mj_JSONString]} complete:^(NSDictionary *responseDic) {
            NSLog(@"%@",responseDic);
            
            YRChatViewController *groupChat = [[YRChatViewController alloc]init];
            groupChat.conversationType = ConversationType_GROUP;
            groupChat.targetId = responseDic[@"id"];
            groupChat.title = responseDic[@"name"];
            
            //显示聊天会话界面
            [self.navigationController pushViewController:groupChat animated:YES];
        } failed:^(NSError *error) {
            
        }];
    }
    [_selectedArray removeAllObjects];
}
#pragma mark - Table view data source

-(NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.letterResultArr objectAtIndex:section]count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.indexArray[section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YRSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YRSearchFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    cell.textLabel.text = [[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] name];
    NSString *avatar = [[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] avatar];
    NSString *name = [[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] name];
    [cell configureCellWithAvatar:avatar name:name];
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAllowSelected) {
        if (![_selectedArray containsObject:indexPath]) {
            [_selectedArray addObject:indexPath];
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        return;
    }
    YRUserDetailController *userDetailVC = [[YRUserDetailController alloc] init];
    userDetailVC.userID = [[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] id];
    [self.navigationController pushViewController:userDetailVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAllowSelected) {
        if ([_selectedArray containsObject:indexPath]) {
            [_selectedArray removeObject:indexPath];
            if (_selectedArray.count == 0) {
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
        }
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除好友";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从数据源中删除
    [_letterResultArr removeObject:[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]];
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    NSString *friendID = [[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] id];
    [RequestData DELETE:[NSString stringWithFormat:@"%@/%@",STUDENT_DELETE_FRIENDS,friendID] parameters:nil complete:^(NSDictionary *responseDic) {
        
    } failed:^(NSError *error) {
        
    }];
    
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

-(UIButton *)myGroup{
    if (!_myGroup) {
        _myGroup = [[UIButton alloc] initWithFrame:CGRectMake(8, 4, kScreenWidth - 23, 50)];
        [_myGroup setTitle:@"我的群组" forState:UIControlStateNormal];
        [_myGroup setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_myGroup addTarget:self action:@selector(myGroupBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _myGroup.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _myGroup.layer.borderWidth = 0.5;
        _myGroup.layer.cornerRadius = 10;
        [_myGroup setImage:[UIImage imageNamed:@"Friend_GroCha"] forState:UIControlStateNormal];
        [_myGroup setImageEdgeInsets:UIEdgeInsetsMake(0, -kScreenWidth/2-20, 0, 0)];
    }
    return _myGroup;
}
-(UIButton *)myCoach{
    if (!_myCoach) {
        _myCoach = [[UIButton alloc] initWithFrame:CGRectMake(8, 58, kScreenWidth - 23, 50)];
        [_myCoach setTitle:@"我的教练" forState:UIControlStateNormal];
        [_myCoach setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_myCoach addTarget:self action:@selector(myCoachBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _myCoach.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _myCoach.layer.borderWidth = 0.5;
        _myCoach.layer.cornerRadius = 10;
        [_myCoach setImage:[UIImage imageNamed:@"Friend_GroCha"] forState:UIControlStateNormal];
        [_myCoach setImageEdgeInsets:UIEdgeInsetsMake(0, -kScreenWidth/2-20, 0, 0)];
    }
    return _myCoach;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 112)];
        [_headerView addSubview:self.myGroup];
        [_headerView addSubview:self.myCoach];
    }
    return _headerView;
}
@end