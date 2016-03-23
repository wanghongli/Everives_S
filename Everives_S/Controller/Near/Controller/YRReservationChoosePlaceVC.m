//
//  YRReservationChoosePlaceVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationChoosePlaceVC.h"

@interface YRReservationChoosePlaceVC ()
@property(nonatomic,strong) UIView *tableHeader;
@end

@implementation YRReservationChoosePlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.tableHeader;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.editing = YES;
    self.tableView.allowsMultipleSelection = NO;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

static NSString *reuseID = @"reuseIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%li",indexPath.row];
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UIView *)tableHeader{
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 30, kScreenWidth-16, 40)];
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = @"_tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWi";
        [label sizeToFit];
        [_tableHeader addSubview:label];
    }
    return _tableHeader;
}


@end
