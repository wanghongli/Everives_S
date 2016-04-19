//
//  YRSettingController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSettingController.h"
#import "YRSettingCell.h"
#import "YRYJNavigationController.h"
#import "YRPrivacySettingController.h"
#import "REFrostedViewController.h"
#import "YRAboutUsViewController.h"
@interface YRSettingController ()
{
    NSArray *_menuArray;
}
@end

@implementation YRSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.frostedViewController.panGestureEnabled = YES;
    _menuArray = @[@[@"隐私设置"],@[@"系统通知提醒",@"驾友消息提醒",@"驾友圈消息提醒"],@[@"关于我们",@"用户反馈",@"系统版本"]];
    self.tableView.backgroundColor = kCOLOR(241, 241, 241);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _menuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menuArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"settingID";
    YRSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section!=1) {
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.swithHidden = YES;
    }else
        cell.swithHidden = NO;
    //开关状态
    cell.swithStatus = indexPath.row%2;
    //开关事件
    [cell setSwithcIsOn:^(BOOL swithOn) {
        
    }];
    cell.textLabel.text = _menuArray[indexPath.section][indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        YRPrivacySettingController *spVC = [[YRPrivacySettingController alloc]init];
        [self.navigationController pushViewController:spVC animated:YES];
    }
    //关于我们
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            YRAboutUsViewController *about = [[YRAboutUsViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }
    }
}
@end
