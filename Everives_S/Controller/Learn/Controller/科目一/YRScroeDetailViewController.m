//
//  YRScroeDetailViewController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/5/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRScroeDetailViewController.h"
#import "YRPublicMethod.h"
#import "YRScroeHeadView.h"
#import "YRScroeDownView.h"
#import "YRMyErrorController.h"
@interface YRScroeDetailViewController ()<YRScroeDownViewDelegate>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) YRScroeHeadView *headView;
@property (nonatomic, strong) YRScroeDownView *downView;
@end

@implementation YRScroeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成绩详情";
    self.titleArray = @[@"日期",@"总用时",@"正确题数",@"正确率"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd hh:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self.dicMsg[@"time"]integerValue]];
    NSString *timeString = [formatter stringFromDate:confromTimesp];
    NSString *rightString = self.objFour ? [NSString stringWithFormat:@"%ld",[self.dicMsg[@"scroe"] integerValue]/2]:self.dicMsg[@"scroe"];
    self.contentArray = @[timeString,[NSString stringWithFormat:@"%@秒",self.dicMsg[@"costTime"]],rightString,[NSString stringWithFormat:@"%@%%",self.dicMsg[@"scroe"]]];
    
    self.headView = [[YRScroeHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 220)];
    self.headView.scroeString = self.dicMsg[@"scroe"];
    self.tableView.tableHeaderView = self.headView;
    
    self.downView = [[YRScroeDownView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.downView.delegate = self;
    self.tableView.tableFooterView = self.downView;
}
-(void)scroeDownViewClick:(NSInteger)btnTag
{
    if (btnTag == 11) {//错题
       YRMyErrorController *errorVC = [[YRMyErrorController alloc]init];
        [self.navigationController pushViewController:errorVC animated:YES];
    }else{//分享
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.detailTextLabel.text = self.contentArray[indexPath.row];
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
