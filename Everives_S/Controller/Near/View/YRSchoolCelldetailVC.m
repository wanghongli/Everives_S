//
//  YRSchoolCelldetailVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSchoolCelldetailVC.h"

static CGFloat headerHeight = 213;
static CGFloat cellHeight = 60;
@interface YRSchoolCelldetailVC (){
    NSArray *_icons;
}
@property(nonatomic,strong)UIImageView *headerView;
@end

@implementation YRSchoolCelldetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    _icons = @[@"Neighborhood_Field_DriSch",@"Neighborhood_Field_Add",@"Neig_Coach_Bespeak",@"Neighborhood_Field_Contacts",@"Neighborhood_Field_Area",@"neighborhood_Field_Facility",@"Neighborhood_Field_Coach"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return cellHeight*2;
    }
    return cellHeight;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = @"所属驾校";
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
        case 4:{
            break;
        }
        case 5:{
            break;
        }
        case 6:{
            break;
        }
        default:
            break;
    }
    cell.imageView.image = [UIImage imageNamed:_icons[indexPath.row]];
    return cell;
}
-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
    }
    return _headerView;
}

@end
