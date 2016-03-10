//
//  YRCircleHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleHeadView.h"
#import "UIView+SDAutoLayout.h"

#define kImgWHPercent 0.24
#define kDistance 5
@interface YRCircleHeadView ()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) UIImageView *sexImg;
@end

@implementation YRCircleHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"timeline_image_placeholder"];
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    CGFloat w = kImgWHPercent*kScreenWidth;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat h = w;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [self addSubview:_imgView];
    _imgView.center = CGPointMake(kScreenWidth/2, (self.frame.size.height-w)/3+w/2);
    _imgView.image = [UIImage imageNamed:@"timeline_image_placeholder"];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = w/2;
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)+kDistance, kScreenWidth, 20)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_nameLabel];
    _nameLabel.text = @"玉祥驾校";
    
    _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame)+kDistance, kScreenWidth, 20)];
    _signLabel.text = @"玉祥驾校学车就是好，有实惠又快又好。";
    _signLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_signLabel];
    _signLabel.font = [UIFont systemFontOfSize:12];
    
}

@end
