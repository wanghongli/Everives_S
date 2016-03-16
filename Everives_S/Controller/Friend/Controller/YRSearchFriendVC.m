//
//  YRSearchFriendVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSearchFriendVC.h"
#import "RequestData.h"
#import "YRUserStatus.h"
#import <UIImageView+WebCache.h>
@interface YRSearchFriendVC ()<UISearchBarDelegate>{
    NSArray *_searchRes;
}
@property(nonatomic,strong)UISearchBar *searchBar;
@end

@implementation YRSearchFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.rowHeight = 50;
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.tableFooterView = [[UIView alloc] init];
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
    return _searchRes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cellID) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 25;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[_searchRes[indexPath.row] avatar]]];
    cell.textLabel.text = [_searchRes[indexPath.row] name];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
    return _searchBar;
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [RequestData GET:STUDENT_FRIENDS parameters:nil complete:^(NSDictionary *responseDic) {
        _searchRes = [YRUserStatus mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
@end
