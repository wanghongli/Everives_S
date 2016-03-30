//
//  YRExamCollectController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/30.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamCollectController.h"
#import "YRExamTypeCollect.h"
@interface YRExamCollectController ()
{
    NSArray *typeArray;
}
@end

@implementation YRExamCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    self.tableView.backgroundColor = kCOLOR(241, 241, 241);
    [self getData];
}
-(void)getData
{
    [RequestData GET:JK_GET_COLLECT parameters:@{@"type":@"0"} complete:^(NSDictionary *responseDic) {
        typeArray = [YRExamTypeCollect mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1+(BOOL)typeArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return typeArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = @"我的收藏";
    }else{
        YRExamTypeCollect *etcObj = typeArray[indexPath.row];
        cell.textLabel.text = etcObj.name;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = kCOLOR(241, 241, 241);
    return view;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
-(void)getDataWithRow:(NSString *)row
{
//    RequestData GET:<#(NSString *)#> parameters:<#(nullable id)#> complete:<#^(NSDictionary *responseDic)complete#> failed:<#^(NSError *error)failed#>
}
@end
