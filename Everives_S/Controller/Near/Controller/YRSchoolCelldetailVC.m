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
    self.title =  @"驾校详情";
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
            [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.tag == 2333) {
                    [obj removeFromSuperview];
                }
            }];
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(16, 18, 22, 22)];
            image.tag = 2333;
            image.image = [UIImage imageNamed:_icons[5]];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 18, kScreenWidth, 22)];
            titleLabel.tag = 2333;
            titleLabel.text = @"场地设施";
            NSString *places = [NSString stringWithFormat:@"侧方位【%@】 半坡起步【%@】 直角转弯【%@】 曲线行驶【%@】 倒车入库【%@】",
                                _model.cfw,_model.bpqb,_model.zjzw,_model.qxxs,_model.dcrk];
            CGSize size = [places sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(kScreenWidth-53, 100)];
            UILabel *contentLab = [[UILabel alloc] init];
            contentLab.tag = 2333;
            contentLab.font = kFontOfLetterMedium;
            contentLab.text = places;
            contentLab.numberOfLines = 0;
            contentLab.lineBreakMode = NSLineBreakByWordWrapping;
            contentLab.frame = CGRectMake(53, 58, size.width, size.height);
            [cell.contentView addSubview:image];
            [cell.contentView addSubview:titleLabel];
            [cell.contentView addSubview:contentLab];
            break;
        }
        case 6:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",@"金牌教练"];
            break;
        }
        default:
            break;
    }
    if (indexPath.row != 5) {
        cell.imageView.image = [UIImage imageNamed:_icons[indexPath.row]];
    }
    return cell;
}
-(UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
    }
    return _headerView;
}

@end
