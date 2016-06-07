//
//  YRCircleZanListController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/6/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleZanListController.h"
#import "YRPraiseMem.h"
#import "UIImageView+WebCache.h"
#import "YRCircleZanListCell.h"
#import "YRUserDetailController.h"
@interface YRCircleZanListController ()
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation YRCircleZanListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点赞列表";
    [self.tableView registerNib:[UINib nibWithNibName:@"YRCircleZanListCell" bundle:nil] forCellReuseIdentifier:@"zanid"];
    [self getData];
    self.tableView.tableFooterView = [[UIView alloc]init];
}
-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"/seeds/praise/%@",self.weiboID] parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        self.array = [NSMutableArray arrayWithArray:[YRPraiseMem mj_objectArrayWithKeyValuesArray:responseDic]];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *zanID = @"zanid";
    
    YRCircleZanListCell *cell = [tableView dequeueReusableCellWithIdentifier:zanID];
    if (cell == nil) {
        cell = [[YRCircleZanListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:zanID];
    }
    YRPraiseMem *praise = self.array[indexPath.row];
    cell.nameLabel.text = praise.name;
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:praise.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    cell.headImg.layer.masksToBounds = YES;
    cell.headImg.layer.cornerRadius = cell.headImg.height/2;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YRPraiseMem *praise = self.array[indexPath.row];
    YRUserDetailController *userVC = [[YRUserDetailController alloc]init];
    if (![KUserManager.id isEqualToString:praise.id]) {//用户自己
        userVC.userID = praise.id;
    }
    [self.navigationController pushViewController:userVC animated:YES];
}
@end
