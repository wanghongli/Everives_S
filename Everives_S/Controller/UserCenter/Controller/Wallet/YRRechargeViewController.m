//
//  YRRechargeViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/4/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRRechargeViewController.h"
#import <Pingpp.h>

@interface YRRechargeViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIView *tableFooter;
@property(nonatomic,strong) UITextField *numberInput;
@property(nonatomic,strong) UIImageView *wechatRightImage;
@property(nonatomic,strong) UIImageView *aliRightImage;
@property(nonatomic,strong) NSString *channel;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.section+indexPath.row) {
        case 0:
        {
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 100, 50)];
            titleL.text = @"充值金额";
            _numberInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 16, kScreenWidth-200, 35)];
            _numberInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, 16, 16)];
            _numberInput.leftViewMode = UITextFieldViewModeAlways;
            _numberInput.layer.borderWidth = 0.5;
            _numberInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _numberInput.layer.cornerRadius = 5;
            _numberInput.keyboardType = UIKeyboardTypeNumberPad;
            _numberInput.placeholder = @"100枚 = 100元";
            _numberInput.delegate = self;
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:_numberInput];
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"支付方式";
            break;
        }
        case 2:
        {
            UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 9, 40, 40)];
            leftImage.image = [UIImage imageNamed:@"MyWallet_WechatPayment"];
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(71, 0, 200, 60)];
            titleL.text = @"微信钱包支付";
            _wechatRightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 17.5, 25, 25)];
            _wechatRightImage.image = [UIImage imageNamed:@"Pay_Selected"];
            [cell.contentView addSubview:leftImage];
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:_wechatRightImage];
            
            break;
        }
        case 3:
        {
            UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 9, 40, 40)];
            leftImage.image = [UIImage imageNamed:@"MyWallet_Alipay"];
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(71, 0, 200, 60)];
            titleL.text = @"微信钱包支付";
            _aliRightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 17.5, 25, 25)];
            _aliRightImage.image = [UIImage imageNamed:@"Pay_NotSelected"];
            [cell.contentView addSubview:leftImage];
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:_aliRightImage];
            
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
    [self.view endEditing:YES];
    if (indexPath.row == 0) {
        return;
    }
    if(indexPath.row == 1){//微信
        _channel = @"wx";
        _wechatRightImage.image = [UIImage imageNamed:@"Pay_Selected"];
        _aliRightImage.image = [UIImage imageNamed:@"Pay_NotSelected"];
    }else{//支付宝
        _channel = @"alipay";
        _wechatRightImage.image = [UIImage imageNamed:@"Pay_NotSelected"];
        _aliRightImage.image = [UIImage imageNamed:@"Pay_Selected"];
    }
    
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
    if ([_numberInput.text integerValue] == 0) {
        return;
    }
    NSDictionary* dict = @{
                           @"channel" : _channel?:@"wx",
                           @"amount"  : _numberInput.text
                           };
    
    [RequestData POST:MONEY_CHARGE parameters:dict complete:^(NSDictionary *responseDic) {
        NSString *charge = [responseDic mj_JSONString];
        [Pingpp createPayment:charge viewController:self appURLScheme:@"demoapp001" withCompletion:^(NSString *result, PingppError *error) {
            NSLog(@"completion block: %@", result);
            if (error == nil) {
                NSLog(@"PingppError is nil");
            } else {
                NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
            }
            
        }];
    } failed:^(NSError *error) {
        
    }];
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location == 0 && [string  hasPrefix:@"0"]) {
        return NO;
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}


@end
