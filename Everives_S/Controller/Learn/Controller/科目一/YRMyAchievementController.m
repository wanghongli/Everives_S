//
//  YRMyAchievementController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyAchievementController.h"
#import "YRPublicMethod.h"
#import "YRScroeDetailViewController.h"
@interface YRMyAchievementController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *msgArray;
@end

@implementation YRMyAchievementController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的成绩";
    self.view.backgroundColor = [UIColor whiteColor];
    self.msgArray = [YRPublicMethod readMsgWithMenu:self.objFour+1];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    NSDictionary *dic = self.msgArray[indexPath.row];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dic[@"time"]integerValue]];
    cell.textLabel.text = [formatter stringFromDate:confromTimesp];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@分",dic[@"scroe"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YRScroeDetailViewController *detailVC = [[YRScroeDetailViewController alloc]init];
    detailVC.dicMsg = self.msgArray[indexPath.row];
    detailVC.objFour = self.objFour;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
