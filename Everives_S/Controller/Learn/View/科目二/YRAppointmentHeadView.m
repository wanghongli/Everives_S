//
//  YRAppointmentHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAppointmentHeadView.h"
#import "YRLearnPartnerObj.h"
#import "UIColor+Tool.h"

#define kHeadImgHeight 90
#define kLOrRImgHeight 45
#define kCenterImgW 25
@interface YRAppointmentHeadView ()
@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIImageView *leftImg;
@property (nonatomic, weak) UIView *rightView;
@property (nonatomic, weak) UIImageView *rightImg;
@property (nonatomic, weak) UIImageView *centerImg;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *detailLabel;

@property (nonatomic, weak) UIButton *headBtn;
@end

@implementation YRAppointmentHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{

    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:headView];
    _headView = headView;
    
    UIImageView *headimg = [[UIImageView alloc]init];
    headimg.image = [UIImage imageNamed:@"head_jiaolian"];
    [_headView addSubview:headimg];
    _headImg = headimg;
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = [UIColor whiteColor];
    [self addSubview:leftView];
    _leftView = leftView;
    
    UIImageView *leftimg = [[UIImageView alloc]init];
    leftimg.image = [UIImage imageNamed:@"head_1"];
    [_leftView addSubview:leftimg];
    _leftImg = leftimg;
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightView];
    _rightView = rightView;
    
    UIImageView *rightimg = [[UIImageView alloc]init];
    rightimg.image = [UIImage imageNamed:@"head_2"];
    [_rightView addSubview:rightimg];
    _rightImg = rightimg;
    
    UIImageView *centerimg = [[UIImageView alloc]init];
    centerimg.image = [UIImage imageNamed:@"BespeakDetail_Arrow"];
    [self addSubview:centerimg];
    _centerImg = centerimg;
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = kFontOfLetterBig;
    namelabel.textAlignment = NSTextAlignmentCenter;
    namelabel.text = @"罗拉尔多";
    namelabel.textColor = KDarkColor;
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    UILabel *detaillabel = [[UILabel alloc]init];
    detaillabel.font = kFontOfLetterMedium;
    detaillabel.textAlignment = NSTextAlignmentCenter;
    detaillabel.text = @"(每个人支付总费用的一半)";
    [self addSubview:detaillabel];
    _detailLabel = detaillabel;
    
    UIButton *headbtn = [[UIButton alloc]init];
    [headbtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:headbtn];
    _headBtn = headbtn;
    
}
- (void)setOrderDetail:(YRLearnOrderDetail *)orderDetail
{
    _orderDetail = orderDetail;
    [_headImg sd_setImageWithURL:[NSURL URLWithString:orderDetail.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    self.nameLabel.text = orderDetail.tname;
    if (orderDetail.partner) {
        self.leftImg.hidden = NO;
        self.rightImg.hidden = NO;
        self.leftView.hidden = NO;
        self.rightView.hidden = NO;
        [self.leftImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        [self.rightImg sd_setImageWithURL:[NSURL URLWithString:orderDetail.partner.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        [self bringSubviewToFront:self.centerImg];
    }else{
        self.leftImg.hidden = YES;
        self.leftView.hidden = YES;
        self.rightImg.hidden = YES;
        self.rightView.hidden = YES;
        self.centerImg.hidden = YES;
    }
    self.detailLabel.text = [YRPublicMethod getOrderStatusWith:orderDetail.status];
    NSArray *statusColor = @[@"F82119",@"FA8038",@"FA8038",@"FA8038",@"8B8C8D",@"8B8C8D"];
    self.detailLabel.textColor = [UIColor colorWithHexString:statusColor[orderDetail.status]];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headView.frame = CGRectMake(kScreenWidth/2-(kHeadImgHeight+15)/2, 10, kHeadImgHeight+7.5, kHeadImgHeight+7.5);
    self.headImg.frame = CGRectMake(7.5/2, 7.5/2, kHeadImgHeight, kHeadImgHeight);
    
    self.headView.layer.masksToBounds = YES;
    self.headView.layer.cornerRadius = self.headView.height/2;
    self.headView.layer.borderWidth = 2;
    self.headView.layer.borderColor = kCOLOR(230, 230, 230).CGColor;
    
    self.leftView.frame = CGRectMake(_headView.x-2, CGRectGetMaxY(self.headView.frame)-kLOrRImgHeight, kLOrRImgHeight, kLOrRImgHeight);
    CGFloat wh = 6;
    self.leftImg.frame = CGRectMake(wh/2, wh/2, kLOrRImgHeight-wh, kLOrRImgHeight-wh);
    self.leftView.layer.masksToBounds = YES;
    self.leftView.layer.cornerRadius = self.leftView.height/2;
    self.leftView.layer.borderWidth = 1.5;
    self.leftView.layer.borderColor = kCOLOR(230, 230, 230).CGColor;
    
    self.rightView.frame = CGRectMake(self.headView.x+(kHeadImgHeight+7.5)/2+2, self.leftView.y, kLOrRImgHeight, kLOrRImgHeight);
    self.rightImg.frame = CGRectMake(wh/2, wh/2, kLOrRImgHeight-wh, kLOrRImgHeight-wh);
    self.rightView.layer.masksToBounds = YES;
    self.rightView.layer.cornerRadius = self.rightView.height/2;
    self.rightView.layer.borderWidth = 1.5;
    self.rightView.layer.borderColor = kCOLOR(230, 230, 230).CGColor;
    
    self.centerImg.frame = CGRectMake(CGRectGetMaxX(self.leftView.frame)+3 - kCenterImgW/2, self.leftView.y+self.leftView.height/2-kCenterImgW*0.78/2, kCenterImgW, kCenterImgW*0.78);
    self.nameLabel.frame = CGRectMake(0, 115, kScreenWidth, 20);
    self.detailLabel.frame = CGRectMake(0, 140, kScreenWidth, 20);
    
    [self setCornerRadiusWith:self.headImg];
    [self setCornerRadiusWith:self.leftImg];
    [self setCornerRadiusWith:self.rightImg];
    
    self.headBtn.frame = self.headImg.frame;
//    [self bringSubviewToFront:self.headImg];
    
}
- (void)headClick
{
    MyLog(@"%s",__func__);
    [self.delegate appointmentHeadViewClick];
}
-(void)setCornerRadiusWith:(UIView *)corView
{
    corView.layer.masksToBounds = YES;
    corView.layer.cornerRadius = corView.height/2;
    corView.layer.borderWidth = 1;
    corView.layer.borderColor = kCOLOR(203, 204, 205).CGColor;
}
@end
