//
//  YRAchievementDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAchievementDetailController.h"
#import "YRScoreDetailHeadView.h"
#import "YRScoreDetailDownView.h"
@interface YRAchievementDetailController ()<YRScoreDetailDownViewDelegate>
{
    NSArray *_titleArray;
    NSArray *_menuArray;
}
@property (nonatomic, strong) YRScoreDetailHeadView *headView;
@property (nonatomic, strong) YRScoreDetailDownView *downView;
@end

@implementation YRAchievementDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"成绩详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
}

-(void)buildUI
{
    _titleArray = @[@"日期",@"总用时",@"正确题数",@"正确率"];
    _menuArray = @[@"2016.01.03 12:08",@"22分45秒",@"47",@"94%"];

    _headView = [[YRScoreDetailHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    self.tableView.tableHeaderView = _headView;
    
    _downView = [[YRScoreDetailDownView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    _downView.delegate = self;
    self.tableView.tableFooterView = _downView;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = _menuArray[indexPath.row];
    return cell;
}
#pragma mark - YRScoreDetailDownViewDelegate
-(void)scoreDetailDownViewBtnClick:(NSInteger)btnTag
{
    if (btnTag == 1) {//查看错题
        
    }else{//分享成绩
    
    }
}
@end
