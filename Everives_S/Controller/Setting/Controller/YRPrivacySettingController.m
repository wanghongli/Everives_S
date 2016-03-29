//
//  YRPrivacySettingController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/29.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPrivacySettingController.h"
#import "YRSettingPrivacyCell.h"
@interface YRPrivacySettingController ()
{
    NSArray *titleArray;
}
@end

@implementation YRPrivacySettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私设置";
    titleArray = @[@"在附近中显示",@"出现在附件中，不显示距离",@"不出现在附近"];
    self.tableView.tableFooterView = [[UIView alloc]init];
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
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"adfa";
    YRSettingPrivacyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRSettingPrivacyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = titleArray[indexPath.row];
    return cell;
}
@end
