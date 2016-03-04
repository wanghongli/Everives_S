//
//  YRUserCenterViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserCenterViewController.h"
#import "YRReservationViewController.h"

@interface YRUserCenterViewController (){
    NSArray *cellNmaes;
    NSArray *cellImgs;
    NSArray *cellClick;
}
@end

@implementation YRUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cellNmaes = @[@"我的预约",@"我的钱包",@"我的评价",@"我的进度",@"活动通知",@"信息认证"];
    cellImgs = @[@"home_click2",@"home_click2",@"home_click2",@"home_click2",@"home_click2",@"home_click2"];
    cellClick = @[];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.rowHeight = 54;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?4:2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = cellNmaes[indexPath.section*4+indexPath.row];
    cell.imageView.image = [UIImage imageNamed:cellImgs[indexPath.section*4+indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSLog(@"%@",cell);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section*4+indexPath.row) {
        case 0:
        {
           [self.navigationController pushViewController: [[YRReservationViewController alloc] init] animated:YES] ;
           break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            break;
        }
        case 3:
        {
            break;
        }
        case 4:
        {
            break;
        }
        case 5:
        {
            break;
        }
            
            
        default:
            break;
    }
    
}

@end
