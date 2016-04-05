//
//  YRLearnProfessionalController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnProfessionalController.h"
#import "YRLearnPracticeController.h"
@interface YRLearnProfessionalController ()
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation YRLearnProfessionalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题练习";
    self.titleArray = @[@"交通法规",@"交通信号灯",@"路况环境",@"机动车驾驶操作"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRLearnPracticeController *practiceVC = [[YRLearnPracticeController alloc]init];
    practiceVC.menuTag = 3;
    practiceVC.perfisonalKind = 121+indexPath.row;
    [self.navigationController pushViewController:practiceVC animated:YES];
    
}
@end
