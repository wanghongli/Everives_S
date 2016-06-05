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
#import "YRMyGroupVC.h"
#import "YRSearchBar.h"

static NSString *cellID = @"cellID";

@interface YRContactVC()<UISearchBarDelegate>{
    NSArray *_ret;//服务器返回的好友列表
    NSMutableArray *_selectedArray;
    NSMutableArray *_searchRes;
}

@property(nonatomic,strong)YRSearchBar *searchBar;
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
    self.title = @"通讯录";
    _selectedArray = @[].mutableCopy;
    _searchRes = @[].mutableCopy;
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
    [RequestData GET:FRIEND_FRIENDS parameters:nil complete:^(NSDictionary *responseDic) {
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
    YRMyGroupVC *myGroupVC = [[YRMyGroupVC alloc] init];
    [self.navigationController pushViewController:myGroupVC animated:YES];
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
        NSMutableArray *groupMenberIds= @[].mutableCopy;
        [groupMenberIds addObjectsFromArray:selectedUserIds];
        [groupMenberIds addObjectsFromArray:_myCoachVC.selectedCoachIDArray];
        NSLog(@"%@",[groupMenberIds mj_JSONString]);
        [RequestData POST:GROUP_GROUP parameters:@{@"data":[groupMenberIds mj_JSONString]} complete:^(NSDictionary *responseDic) {
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerID"];
    if(!header){
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerID"];
        header.contentView.backgroundColor = [UIColor whiteColor];
        header.layer.borderColor = kCOLOR(240, 240, 240).CGColor;
        header.layer.borderWidth = 1;
        
    }
    header.textLabel.text = [NSString stringWithFormat:@"   %@",self.indexArray[section]];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
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
    [RequestData DELETE:[NSString stringWithFormat:@"%@/%@",FRIEND_FRIEND,friendID] parameters:nil complete:^(NSDictionary *responseDic) {
        
    } failed:^(NSError *error) {
        
    }];
    
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchRes removeAllObjects];
    [searchBar resignFirstResponder];
    if (searchBar.text.length == 0) {
        return;
    }
    [_ret enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YRUserStatus *user = (YRUserStatus*)obj;
        if ([user.name containsString:searchBar.text]||[user.tel containsString:searchBar.text]) {
            [_searchRes addObject:obj];
        }
    }];
    if (_searchRes.count == 0) {
        [MBProgressHUD showSuccess:@"没有找到符合条件的用户~" toView:self.view];
    }else{
        self.indexArray = [ChineseString IndexArray:_searchRes];
        self.letterResultArr = [ChineseString LetterSortArray:_searchRes];
        [self.tableView reloadData];
    }
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.text = @"";
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (searchBar.text.length == 0) {
        searchBar.text = @"搜索";
        if (_ret) {
            self.indexArray = [ChineseString IndexArray:_ret];
            self.letterResultArr = [ChineseString LetterSortArray:_ret];
            [self.tableView  reloadData];
        }
    }
}
#pragma mark - Getters

-(YRSearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[YRSearchBar alloc] initWithFrame:CGRectMake(13, 8, kScreenWidth-28, 44)];
        _searchBar.searchBar.delegate = self;
        
    }
    return _searchBar;
}

-(UIButton *)myGroup{
    if (!_myGroup) {
        _myGroup = [[UIButton alloc] initWithFrame:CGRectMake(-1, 64, kScreenWidth+2, 60)];
        [_myGroup setTitle:@"我的群聊" forState:UIControlStateNormal];
        [_myGroup setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [_myGroup setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_myGroup addTarget:self action:@selector(myGroupBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _myGroup.layer.borderColor = kCOLOR(240, 240, 240).CGColor;
        _myGroup.layer.borderWidth = 1;
        [_myGroup setImage:[UIImage imageNamed:@"Friend_PhoneBook_GroCha"] forState:UIControlStateNormal];
        [_myGroup setImageEdgeInsets:UIEdgeInsetsMake(0, -kScreenWidth/2-50, 0, 0)];
        
    }
    return _myGroup;
}
-(UIButton *)myCoach{
    if (!_myCoach) {
        _myCoach = [[UIButton alloc] initWithFrame:CGRectMake(-1, 118, kScreenWidth+2, 60)];
        [_myCoach setTitle:@"我的教练" forState:UIControlStateNormal];
        [_myCoach setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_myCoach setTitleEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
        [_myCoach addTarget:self action:@selector(myCoachBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _myCoach.layer.borderColor = kCOLOR(240, 240, 240).CGColor;
        _myCoach.layer.borderWidth = 1;
        [_myCoach setImage:[UIImage imageNamed:@"Friend_PhoneBook_Coach"] forState:UIControlStateNormal];
        [_myCoach setImageEdgeInsets:UIEdgeInsetsMake(5, -kScreenWidth/2-50, 0, 0)];
    }
    return _myCoach;
}

-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 178)];
        [_headerView addSubview:self.searchBar];
        [_headerView addSubview:self.myGroup];
        [_headerView addSubview:self.myCoach];
    }
    return _headerView;
}
@end