//
//  YRAppointmentHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAppointmentHeadView.h"
#import "YRLearnPartnerObj.h"
#define kHeadImgHeight 90
#define kLOrRImgHeight 45
#define kCenterImgW 20
@interface YRAppointmentHeadView ()
@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UIImageView *leftImg;
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

    UIImageView *headimg = [[UIImageView alloc]init];
    headimg.image = [UIImage imageNamed:@"head_jiaolian"];
    [self addSubview:headimg];
    _headImg = headimg;
    
    UIImageView *leftimg = [[UIImageView alloc]init];
    leftimg.image = [UIImage imageNamed:@"head_1"];
    [self addSubview:leftimg];
    _leftImg = leftimg;
    
    UIImageView *rightimg = [[UIImageView alloc]init];
    rightimg.image = [UIImage imageNamed:@"head_2"];
    [self addSubview:rightimg];
    _rightImg = rightimg;
    
    UIImageView *centerimg = [[UIImageView alloc]init];
    centerimg.image = [UIImage imageNamed:@"BespeakDetail_Arrow"];
    [self addSubview:centerimg];
    _centerImg = centerimg;
    
    UILabel *namelabel = [[UILabel alloc]init];
    namelabel.font = [UIFont systemFontOfSize:15];
    namelabel.textAlignment = NSTextAlignmentCenter;
    namelabel.text = @"罗拉尔多";
    [self addSubview:namelabel];
    _nameLabel = namelabel;
    
    UILabel *detaillabel = [[UILabel alloc]init];
    detaillabel.font = [UIFont systemFontOfSize:15];
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
        [self.leftImg sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        [self.rightImg sd_setImageWithURL:[NSURL URLWithString:orderDetail.partner.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        [self bringSubviewToFront:self.centerImg];
    }else{
        self.leftImg.hidden = YES;
        self.rightImg.hidden = YES;
        self.centerImg.hidden = YES;
    }
    self.detailLabel.text = [YRPublicMethod getOrderStatusWith:orderDetail.status];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImg.frame = CGRectMake(kScreenWidth/2-kHeadImgHeight/2, 15, kHeadImgHeight, kHeadImgHeight);
    self.leftImg.frame = CGRectMake(_headImg.x-2, 70, kLOrRImgHeight, kLOrRImgHeight);
    self.rightImg.frame = CGRectMake(self.headImg.x+kHeadImgHeight/2+2, self.leftImg.y, kLOrRImgHeight, kLOrRImgHeight);
    self.centerImg.frame = CGRectMake(CGRectGetMaxX(self.leftImg.frame)+3 - kCenterImgW/2, self.leftImg.y+self.leftImg.height/2-kCenterImgW*0.78/2, kCenterImgW, kCenterImgW*0.78);
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
