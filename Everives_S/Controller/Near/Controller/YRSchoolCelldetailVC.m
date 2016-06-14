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
#import "ZHScrollImageView.h"
#import "YRGoldenTeacherVC.h"

static CGFloat headerHeight = 213;
static CGFloat cellHeight = 60;
@interface YRSchoolCelldetailVC ()<UIAlertViewDelegate>{
    NSArray *_icons;
}
@property(nonatomic,strong) YRSchoolModel *model;
@property(nonatomic,strong) ZHScrollImageView *headerView;
@end

@implementation YRSchoolCelldetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"驾校详情";
    self.tableView.tableHeaderView = self.headerView;
    [self getData];
    _icons = @[@"Neighborhood_Field_DriSch",@"Neighborhood_Field_Add",@"Friend_AddFri_Contacts",@"Neighborhood_Field_Contacts",@"Neighborhood_Field_Area",@"neighborhood_Field_Facility",@"Neighborhood_Field_More",@"Neighborhood_Field_Coach"];
}

-(void)getData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [RequestData GET:[NSString stringWithFormat:@"%@/%@",STUDENT_PLACES,_placeID] parameters:nil complete:^(NSDictionary *responseDic) {
        _model = [YRSchoolModel mj_objectWithKeyValues:responseDic];
        self.title = _model.name;
        [self.tableView reloadData];
        _headerView.models = _model.pics;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5||indexPath.row == 6) {
        return cellHeight*2;
    }
    return cellHeight;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.row) {
        case 0:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"所属驾校 : ",_model.school];
            break;
        }
        case 1:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"地址 : ",_model.address];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 2:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"联系方式 : ",_model.tel];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 3:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"场地联系人 : ",_model.admin];
            break;
        }
        case 4:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",@"面积 : ",[_model.area integerValue]?_model.area:@"未知"];
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
            titleLabel.textColor = kYRBlackTextColor;
            NSString *places = [NSString stringWithFormat:@"侧方位【%@】 半坡起步【%@】 直角转弯【%@】 曲线行驶【%@】 倒车入库【%@】",
                                _model.cfw,_model.bpqb,_model.zjzw,_model.qxxs,_model.dcrk];
            CGSize size = [places sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(kScreenWidth-53, 100)];
            UILabel *contentLab = [[UILabel alloc] init];
            contentLab.tag = 2333;
            contentLab.font = kFontOfLetterMedium;
            contentLab.textColor = kYRBlackTextColor;
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
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(16, 18, 22, 22)];
            image.tag = 2333;
            image.image = [UIImage imageNamed:_icons[6]];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 18, kScreenWidth, 22)];
            titleLabel.tag = 2333;
            titleLabel.text = @"场地介绍";
            titleLabel.textColor = kYRBlackTextColor;
            NSString *intro = _model.intro?:@"这个场地还没有任何介绍哦~";
            CGSize size = [intro sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(kScreenWidth-53, 100)];
            UILabel *contentLab = [[UILabel alloc] init];
            contentLab.tag = 2333;
            contentLab.font = kFontOfLetterMedium;
            contentLab.textColor = kYRBlackTextColor;
            contentLab.text = intro;
            contentLab.numberOfLines = 0;
            contentLab.lineBreakMode = NSLineBreakByWordWrapping;
            contentLab.frame = CGRectMake(53, 58, size.width, size.height);
            [cell.contentView addSubview:image];
            [cell.contentView addSubview:titleLabel];
            [cell.contentView addSubview:contentLab];
            break;
        }
        case 7:{
            cell.textLabel.text = [NSString stringWithFormat:@"%@",@"金牌教练"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        default:
            break;
    }
    if (indexPath.row != 5 &&indexPath.row!=6) {
        cell.imageView.image = [UIImage imageNamed:_icons[indexPath.row]];
        cell.textLabel.textColor = kYRBlackTextColor;
        cell.textLabel.font = kFontOfLetterBig;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //打开地图
    if(indexPath.row == 1){
        NSString *urlString = [[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%@,%@&saddr=%@,%@",_model.lat, _model.lng,KUserLocation.latitude,KUserLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    //打开拨号键盘
    if(indexPath.row  == 2){
        if (_model.tel.length>6) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否拨打电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"是", nil];
            alert.tag = 2333;
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [alert show];
        }
    }
    //金牌教练
    if (indexPath.row == 7) {
        YRGoldenTeacherVC *goldenTeacherVC = [[YRGoldenTeacherVC alloc] init];
        goldenTeacherVC.placeID = _placeID;
        [self.navigationController pushViewController:goldenTeacherVC animated:YES];
    }
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 2333 && buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", _model.tel]];
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - Getters
-(ZHScrollImageView *)headerView{
    if (!_headerView) {
        _headerView = [[ZHScrollImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
    }
    return _headerView;
}

@end
