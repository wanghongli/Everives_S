//
//  YRAppointmentDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAppointmentDetailController.h"
#import "YRAppointmentHeadView.h"
#import "YRTeacherDetailController.h"
#import "YRLearnOrderDetail.h"
#import "YRLearnOrderDetailInfo.h"
#import "YRTeacherMakeCommentController.h"
#import "YRChatViewController.h"
#import "YRLearnPartnerObj.h"

@interface YRAppointmentDetailController () <YRAppointmentHeadViewDelegate,UIAlertViewDelegate>
{
    NSArray *_titleArray;
    NSArray *_menuArray;
    NSMutableArray *_totalMenu;
}
@property (nonatomic, strong) YRAppointmentHeadView *headView;//头部视图
@property (nonatomic, strong) YRLearnOrderDetail *orderDetail;//详情模型
@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIButton *cancelOrderBtn;
@end

@implementation YRAppointmentDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"预约时间",@"学车时段",@"训练场地",@"预约费用"];
    _menuArray = @[@"2016年3月4日 星期五",@"14:00-16:00&17:00-18:00",@"玉祥驾校南山区",@"￥450"];
    _headView = [[YRAppointmentHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    _headView.delegate = self;
    self.tableView.tableHeaderView = self.headView;
    
    
    [self getData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:GET_WINDOW];
    [RequestData GET:[NSString stringWithFormat:@"/order/order/%@",self.orderId] parameters:@{} complete:^(NSDictionary *responseDic) {
        NSLog(@"%@",responseDic);
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
        self.orderDetail = [YRLearnOrderDetail mj_objectWithKeyValues:responseDic];
        self.headView.orderDetail = self.orderDetail;
        _totalMenu = [NSMutableArray array];
        for (int i = 0 ; i<self.orderDetail.info.count; i++) {
            YRLearnOrderDetailInfo *detailInfo = self.orderDetail.info[i];
            NSString *orderTime = [YRPublicMethod getDateAndWeekWith:detailInfo.date];;
            NSString *string = [YRPublicMethod getDetailLearnTimeWith:detailInfo.time];
            NSString *price = [NSString stringWithFormat:@"￥%ld",detailInfo.price];
            _menuArray = @[orderTime,string,detailInfo.place,price];
            [_totalMenu addObject:_menuArray];
        }
        
        [self.tableView reloadData];
        [self addFooterView];
        [self setStarBtnTitle:[YRPublicMethod getOrderStatusWith:self.orderDetail.status]];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:GET_WINDOW animated:YES];
    }];
}

#pragma amrk - 根据订单状态判断底部视图布局
-(void)addFooterView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 115)];
    self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, kScreenWidth-40, 40)];
    [self.startBtn setTitle:@"发消息" forState:UIControlStateNormal];
    [self.startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.startBtn.backgroundColor = kCOLOR(50, 51, 52);
    [self.startBtn addTarget:self action:@selector(startClick:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn.layer.masksToBounds = YES;
    self.startBtn.layer.cornerRadius = self.startBtn.height/2;
    
    self.cancelOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 60, kScreenWidth-40, 40)];
    self.cancelOrderBtn.layer.masksToBounds = YES;
    self.cancelOrderBtn.layer.cornerRadius = self.startBtn.height/2;
    switch (_orderDetail.cancle) {
        case 1://申请取消订单
        {
            [self.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelOrderBtn.backgroundColor = kCOLOR(228, 69, 69);
            [self.cancelOrderBtn addTarget:self action:@selector(cancelOrderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case 500:
        {
            if (_orderDetail.cancleReplyer == [KUserManager.id integerValue]) {
                UIAlertView *responseCancel = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"你的驾友%@申请取消订单,是否同意",((YRLearnPartnerObj*)(_orderDetail.partner)).name] delegate:self cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意", nil];
                responseCancel.tag = 2;
                [responseCancel show];
            }else{
                [self.cancelOrderBtn setTitle:@"已申请取消订单" forState:UIControlStateNormal];
                [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                self.cancelOrderBtn.backgroundColor = kCOLOR(228, 69, 69);
            }
            break;
        }
        case 501:
        {
            [self.cancelOrderBtn setTitle:@"等待审核取消订单" forState:UIControlStateNormal];
            [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelOrderBtn.backgroundColor = kCOLOR(228, 69, 69);
            break;
        }
        case 502:
        {
            [self.cancelOrderBtn setTitle:@"取消订单已拒绝" forState:UIControlStateNormal];
            [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelOrderBtn.backgroundColor = kCOLOR(228, 69, 69);
            break;
        }
        case 503:
        {
            [self.cancelOrderBtn setTitle:@"等待审核取消订单" forState:UIControlStateNormal];
            [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelOrderBtn.backgroundColor = kCOLOR(228, 69, 69);
            break;
        }
        case 504:
        {
            [self.cancelOrderBtn setTitle:@"取消订单审核失败" forState:UIControlStateNormal];
            [self.cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cancelOrderBtn.backgroundColor = kCOLOR(228, 69, 69);
            break;
        }
            
        default:
            self.cancelOrderBtn = nil;
            break;
    }
    
    
    [footView addSubview:self.startBtn];
    [footView addSubview:self.cancelOrderBtn];
    self.tableView.tableFooterView = footView;
}
-(void)setStarBtnTitle:(NSString *)titleString
{
    
    if ([titleString isEqualToString:@"未支付"]) {
        if (_orderDetail.partner != 0) {
            [self.startBtn setTitle:@"确认拼教练" forState:UIControlStateNormal];
        }else{
            [self.startBtn setTitle:@"去支付" forState:UIControlStateNormal];
        }
    }else if ([titleString isEqualToString:@"已完成,等待评价"]){
        [self.startBtn setTitle:@"去评价" forState:UIControlStateNormal];
    }else{
        [self.startBtn setTitle:@"发消息" forState:UIControlStateNormal];
    }
}
-(void)startClick:(UIButton *)sender
{
    //去支付
    if ([sender.titleLabel.text isEqualToString:@"去支付"]||[sender.titleLabel.text isEqualToString:@"确认拼教练"]) {
        sender.enabled = NO;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认支付" message:@"订单已生成，确认支付？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"支付", nil];
        alertView.tag = 1;
        [alertView show];
    }else if ([sender.titleLabel.text isEqualToString:@"去评价"]){//去评价
        YRTeacherMakeCommentController *makeCommentVC = [[YRTeacherMakeCommentController alloc]init];
        makeCommentVC.orderID = [NSString stringWithFormat:@"%ld",self.orderDetail.id];
        [self.navigationController pushViewController:makeCommentVC animated:YES];
    }else{//发送消息
        YRChatViewController *conversationVC = [[YRChatViewController alloc]init];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = [NSString stringWithFormat:@"tea%li",_orderDetail.tid];
        conversationVC.title = _orderDetail.tname;
        conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
        conversationVC.enableUnreadMessageIcon=YES;
        [self.navigationController pushViewController:conversationVC animated:YES];
    }
}
- (void)cancelOrderBtnClick:(UIButton*)sender{
    UIAlertView *confirmCancel = [[UIAlertView alloc] initWithTitle:nil message:@"确认取消订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    confirmCancel.tag = 3;
    [confirmCancel show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderDetail.info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = kCOLOR(34, 36, 38);
    cell.indentationLevel = 2;
    NSArray *array = _totalMenu[indexPath.section];
    //机智...UILabel会自动清空末尾的空格，而且cell的textlabel都是不能移动的，就用了这个方法
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@       .",array[indexPath.row]]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,str.length-1)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(str.length-1,1)];
    cell.detailTextLabel.attributedText =str;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.orderDetail.info.count-1) {
        return 2;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        //确认支付
        if (buttonIndex == 1) {
            [RequestData GET:[NSString stringWithFormat:@"%@%@",STUDENT_PAY,_orderId] parameters:nil complete:^(NSDictionary *responseDic) {
                UIAlertView *successAlertView = [[UIAlertView alloc] initWithTitle:@"支付成功" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [successAlertView show];
                [self.startBtn setTitle:@"发消息" forState:UIControlStateNormal];
            } failed:^(NSError *error) {
                UIAlertView *failureAlertView = [[UIAlertView alloc] initWithTitle:@"支付失败" message:@"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [failureAlertView show];
                _startBtn.enabled = YES;
            }];
        }else{//确定  取消
            _startBtn.enabled = YES;
        }
    }else if(alertView.tag == 2){
        self.cancelOrderBtn.enabled = NO;
        if (buttonIndex == 1) {
            //被动方同意取消订单
            [RequestData PUT:[NSString stringWithFormat:@"%@%li",STUDENT_CANCEL_RES,_orderDetail.id] parameters:@{@"status":@"1"} complete:^(NSDictionary *responseDic) {
                [self.cancelOrderBtn setTitle:@"已同意取消订单" forState:UIControlStateNormal];
            } failed:^(NSError *error) {
                
            }];
        }else{
            //被动方拒绝取消订单
            [RequestData PUT:[NSString stringWithFormat:@"%@%li",STUDENT_CANCEL_RES,_orderDetail.id] parameters:@{@"status":@"0"} complete:^(NSDictionary *responseDic) {
                [self.cancelOrderBtn setTitle:@"已拒绝取消订单" forState:UIControlStateNormal];
            } failed:^(NSError *error) {
                
            }];
        }
    }else if(alertView.tag == 3){
        if (buttonIndex == 1) {//非合拼订单，确定取消订单
            [RequestData DELETE:[NSString stringWithFormat:@"%@%li",STUDENT_ORDER,_orderDetail.id] parameters:nil complete:^(NSDictionary *responseDic) {
                [self.cancelOrderBtn setTitle:@"已申请取消订单" forState:UIControlStateNormal];
                self.cancelOrderBtn.enabled = NO;
            } failed:^(NSError *error) {
                [MBProgressHUD showError:@"取消失败" toView:self.view];
            }];
        }
    }
    
}

- (void)appointmentHeadViewClick
{
    YRTeacherDetailController *tdc = [[YRTeacherDetailController alloc]init];
    tdc.teacherID = [NSString stringWithFormat:@"%ld",self.orderDetail.tid];
    [self.navigationController pushViewController:tdc animated:YES];
}
@end
