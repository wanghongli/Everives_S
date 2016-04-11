//
//  YROrderConfirmViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YROrderConfirmViewController.h"
#import "YRTeacherDetailObj.h"
#import "YRStarsView.h"
static NSString *cellID = @"cellID";
@interface YROrderConfirmViewController (){
    NSArray *_times;
}
@property(nonatomic,strong) UIView *coachView;
@end

@implementation YROrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _times = @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(commitBtnClick:)];
}

-(void)commitBtnClick:(UIBarButtonItem*)sender{
    
    //        [RequestData POST:STUDENT_ORDER parameters:parameters complete:^(NSDictionary *responseDic) {
    //
    //        } failed:^(NSError *error) {
    //
    //        }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section) {
        return 70;
    }
    switch (indexPath.row) {
        case 0:
        case 1:
            return 70;
        case 2:
            return 50+30*_DateTimeArray.count;
        case 3:
            return 100;
        default:
            return 0;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?:4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section?10:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 40, 30)];
    switch (indexPath.section*4+indexPath.row) {
        case 0:
        {
            titleLab.text = @"驾校";
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 100, 30)];
            contentLab.text = @"玉祥驾校";
            [cell.contentView addSubview:titleLab];
            [cell.contentView addSubview:contentLab];
            return  cell;
        }
        case 1:
        {
            titleLab.text = @"项目";
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 70, 30)];
            contentLab.text = _coachModel.kind?@"科目三":@"科目二";
            contentLab.textAlignment = NSTextAlignmentCenter;
            contentLab.backgroundColor = [UIColor colorWithRed:43/255.0 green:162/255.0 blue:238/255.0 alpha:1.0];
            contentLab.layer.cornerRadius = 15;
            contentLab.layer.masksToBounds = YES;
            [cell.contentView addSubview:titleLab];
            [cell.contentView addSubview:contentLab];
            return  cell;
        }
        case 2:
        {
            titleLab.text = @"时段";
            [_DateTimeArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20+30*idx, kScreenWidth -60, 30)];
                contentLab.text = [NSString stringWithFormat:@"%@ %@ %@",obj[@"date"],[NSString getTheDayInWeek:obj[@"date"]],_times[[obj[@"time"] integerValue]]];
                [cell.contentView addSubview:contentLab];
            }];
            [cell.contentView addSubview:titleLab];
            return  cell;
        }
        case 3:
        {
            titleLab.text = @"教练";
            [cell.contentView addSubview:self.coachView];
            [cell.contentView addSubview:titleLab];
            return  cell;
        }
        case 4:
        {
            titleLab.text = @"合计";
            UILabel *contentLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 100, 30)];
            contentLab.text = @"￥400";
            contentLab.textColor = [UIColor redColor];
            [cell.contentView addSubview:titleLab];
            [cell.contentView addSubview:contentLab];
            return  cell;
        }
            
        default:
            return cell;
    }
}
-(UIView *)coachView{
    if (!_coachView) {
        _coachView.backgroundColor = [UIColor colorWithWhite:0.748 alpha:1.000];
        _coachView = [[UIView alloc] initWithFrame:CGRectMake(90, 10, kScreenWidth - 60, 80)];
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 5, 70, 70)];
        avatar.layer.cornerRadius = 35;
        [avatar sd_setImageWithURL:[NSURL URLWithString:_coachModel.avatar]];
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, kScreenWidth - 200, 30)];
        name.text = _coachModel.name;
        YRStarsView * stars = [[YRStarsView alloc] initWithFrame:CGRectMake(110, 35, 120, 30) score:[_coachModel.grade integerValue]  starWidth:20 intervel:3 needLabel:YES];
        [_coachView addSubview:avatar];
        [_coachView addSubview:name];
        [_coachView addSubview:stars];
        
    }
    return _coachView;
}
@end
