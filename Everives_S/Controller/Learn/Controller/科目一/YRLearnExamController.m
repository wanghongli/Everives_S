//
//  YRLearnExamController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnExamController.h"
#import "YRLearnPracticeController.h"
@interface YRLearnExamController ()
{
    NSArray *_titleArray;
    NSArray *_menuArray;
}
@end

@implementation YRLearnExamController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"考试科目",@"考试题库",@"考试标准",@"合格标准"];
    _menuArray = @[@"科目一理论考试",@"重庆市科目一理论考试题库",@"30分钟，50题",@"满分100分，90分及格"];
    self.title = @"模拟考试";
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    self.tableView.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, footView.height-40, kScreenWidth-40, 40)];
    [startBtn setTitle:@"开始考试" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.backgroundColor = kCOLOR(50, 51, 52);
    [startBtn addTarget:self action:@selector(sartClick:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = startBtn.height/2;
    [footView addSubview:startBtn];
    self.tableView.tableFooterView = footView;
}
-(void)sartClick:(UIButton *)sender
{
    YRLearnPracticeController *learnVC = [[YRLearnPracticeController alloc]init];
    learnVC.title = @"模拟考试";
    [self.navigationController pushViewController:learnVC animated:YES];
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



@end
