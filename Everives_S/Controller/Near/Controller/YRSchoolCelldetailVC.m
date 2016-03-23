//
//  YRSchoolCelldetailVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSchoolCelldetailVC.h"
#import "RequestData.h"
#import <UIImageView+WebCache.h>
#import "YRSchoolModel.h"
#import <MJExtension.h>
#import "YRPictureModel.h"
static CGFloat headerHeight = 213;
static CGFloat cellHeight = 60;
@interface YRSchoolCelldetailVC (){
    NSArray *_icons;
}
@property(nonatomic,strong) YRSchoolModel *model;
@property(nonatomic,strong)UIImageView *headerView;
@end

@implementation YRSchoolCelldetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.headerView;
    [self getData];
    _icons = @[@"Neighborhood_Field_DriSch",@"Neighborhood_Field_Add",@"Neig_Coach_Bespeak",@"Neighborhood_Field_Contacts",@"Neighborhood_Field_Area",@"neighborhood_Field_Facility",@"Neighborhood_Field_Coach"];
}

-(void)getData{
    [RequestData GET:[NSString stringWithFormat:@"%@/%@",STUDENT_PLACES,_placeID] parameters:nil complete:^(NSDictionary *responseDic) {
        _model = [YRSchoolModel mj_objectWithKeyValues:responseDic];
        [self.tableView reloadData];
        [_headerView sd_setImageWithURL:[NSURL URLWithString:((YRPictureModel*)(_model.pics[0])).url]];
    } failed:^(NSError *error) {
        
    }];
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
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"所属驾校:",_model.school];
            break;
        }
        case 1:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"地址:",_model.address];
            break;
        }
        case 2:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"联系方式:",_model.tel];
            break;
        }
        case 3:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"场地联系人:",_model.admin];
            break;
        }
        case 4:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"面积:",_model.area];
            break;
        }
        case 5:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",@"场地设施"];
            break;
        }
        case 6:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",@"金牌教练"];
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
