//
//  YRRechargeViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/4/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRRechargeViewController.h"

@interface YRRechargeViewController ()
@property(nonatomic,strong) UIView *tableFooter;
@end

@implementation YRRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = self.tableFooter;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?3:1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    switch (indexPath.section+indexPath.row) {
        case 0:
        {
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 100, 50)];
            titleL.text = @"充值金额";
            UITextField *numInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 16, kScreenWidth-200, 35)];
            numInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, 16, 16)];
            numInput.leftViewMode = UITextFieldViewModeAlways;
            numInput.layer.borderWidth = 0.5;
            numInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
            numInput.layer.cornerRadius = 5;
            numInput.placeholder = @"100枚 = 100元";
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:numInput];
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"支付方式";
            break;
        }
        case 2:
        {
            cell.imageView.image = [UIImage imageNamed:@"MyWallet_WechatPayment"];
            cell.textLabel.text = @"微信钱包支付";
            break;
        }
        case 3:
        {
            cell.imageView.image = [UIImage imageNamed:@"MyWallet_Alipay"];
            cell.textLabel.text = @"支付宝支付";
            break;
        }
        default:
            break;
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *sectionHeaderID = @"headerID";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderID];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:sectionHeaderID];
    }
    header.backgroundColor = [UIColor lightGrayColor];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIView *)tableFooter{
    if (!_tableFooter) {
        _tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 40, kScreenWidth-160, 50)];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitle:@"确认支付" forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:kCOLOR(43, 162, 238)];
        sureBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        sureBtn.layer.borderWidth = 0.5;
        sureBtn.layer.cornerRadius = 25;
        [_tableFooter addSubview:sureBtn];
        
    }
    return _tableFooter;
}
-(void)sureBtnClick:(UIButton*)sender{
    
}
@end
