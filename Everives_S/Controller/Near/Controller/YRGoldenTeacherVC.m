//
//  YRGoldenTeacherVC.m
//  Everives_S
//
//  Created by darkclouds on 16/4/26.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRGoldenTeacherVC.h"
#import "YRCoachTableCell.h"
#import "YRCoachModel.h"
static NSString *cellReuseID = @"cellReuseID";
@interface YRGoldenTeacherVC ()
@property(nonatomic,strong) NSArray *models;
@end

@implementation YRGoldenTeacherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金牌教练";
    self.clearsSelectionOnViewWillAppear = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    [self.tableView registerNib:[UINib nibWithNibName:@"YRCoachTableCell" bundle:nil] forCellReuseIdentifier:cellReuseID];
    self.tableView.rowHeight = 100;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self getData];
    
}
-(void)getData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"%@   %@",PLACE_TEACHER,_placeID);
    [RequestData GET:[NSString stringWithFormat:@"%@%@",PLACE_TEACHER,_placeID] parameters:nil complete:^(NSDictionary *responseDic) {
        _models = [YRCoachModel mj_objectArrayWithKeyValuesArray:responseDic];
        [self.tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YRCoachTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID forIndexPath:indexPath];
    cell.model = _models[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
