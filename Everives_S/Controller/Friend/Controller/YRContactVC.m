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
static NSString *cellID = @"cellID";
@interface YRContactVC ()<UISearchBarDelegate>{
    NSArray *_ret;//服务器返回的好友列表
}

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UIButton *myGroup;
@property(nonatomic,strong)UIButton *myCoach;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)NSMutableArray *indexArray;//去重后的首字母，右侧导航
@property(nonatomic,strong)NSMutableArray *letterResultArr;//按照首字母排序后的集合

@end

@implementation YRContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 50;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerNib:[UINib nibWithNibName:@"YRSearchFriendCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    YRUserStatus *user1 = [YRUserStatus new];
    user1.name = @"叶良辰";
    YRUserStatus *user2 = [YRUserStatus new];
    user2.name = @"王尼玛";
    YRUserStatus *user3 = [YRUserStatus new];
    user3.name = @"张日天";
    YRUserStatus *user4 = [YRUserStatus new];
    user4.name = @"王二狗";
    YRUserStatus *user5 = [YRUserStatus new];
    user5.name = @"赵铁柱";
    YRUserStatus *user6 = [YRUserStatus new];
    user6.name = @"安鸡啦逼逼";
    YRUserStatus *user7 = [YRUserStatus new];
    user7.name = @"林立屌";
    YRUserStatus *user8 = [YRUserStatus new];
    user8.name = @"蒙多";
    YRUserStatus *user9 = [YRUserStatus new];
    user9.name = @"曹操";
    YRUserStatus *user10 = [YRUserStatus new];
    user10.name = @"福尔康";
    YRUserStatus *user11 = [YRUserStatus new];
    user11.name = @"艾薇儿";
    YRUserStatus *user12 = [YRUserStatus new];
    user12.name = @"泰勒儿";
    YRUserStatus *user13 = [YRUserStatus new];
    user13.name = @"天海翼";
    _ret = @[user1,user2,user3,user4,user5,user6,user7,user8,user9,user10,user11,user12,user13];
    if (_ret) {
        self.indexArray = [ChineseString IndexArray:_ret];
        self.letterResultArr = [ChineseString LetterSortArray:_ret];
        [self.tableView  reloadData];
    }
}


-(void)myGroupBtnClick:(UIButton*)sender{
    
}
-(void)myCoachBtnClick:(UIButton*)sender{
    
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
    if (cellID) {
        cell = [[YRSearchFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [[[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] name];
    return cell;
}



#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}
#pragma mark - Getters
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-15, 50)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入驾友用户名或手机号码";
    }
    return _searchBar;
}
-(UIButton *)myGroup{
    if (!_myGroup) {
        _myGroup = [[UIButton alloc] initWithFrame:CGRectMake(8, 54, kScreenWidth - 23, 50)];
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
        _myCoach = [[UIButton alloc] initWithFrame:CGRectMake(8, 104, kScreenWidth - 23, 50)];
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
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 154)];
        [_headerView addSubview:self.searchBar];
        [_headerView addSubview:self.myGroup];
        [_headerView addSubview:self.myCoach];
    }
    return _headerView;
}
@end