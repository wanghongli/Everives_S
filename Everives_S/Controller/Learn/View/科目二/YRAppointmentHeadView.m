//
//  YRAppointmentHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAppointmentHeadView.h"

#define kHeadImgHeight 80
#define kLOrRImgHeight 35
@interface YRAppointmentHeadView ()
@property (nonatomic, weak) UIImageView *headImg;
@property (nonatomic, weak) UIImageView *leftImg;
@property (nonatomic, weak) UIImageView *rightImg;
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
    self.leftImg.hidden = YES;
    self.rightImg.hidden = YES;
    self.detailLabel.text = [YRPublicMethod getOrderStatusWith:orderDetail.status];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImg.frame = CGRectMake(kScreenWidth/2-kHeadImgHeight/2, 20, kHeadImgHeight, kHeadImgHeight);
    self.leftImg.frame = CGRectMake(_headImg.x-3, 70, kLOrRImgHeight, kLOrRImgHeight);
    self.rightImg.frame = CGRectMake(self.headImg.x+52, self.leftImg.y, kLOrRImgHeight, kLOrRImgHeight);
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
