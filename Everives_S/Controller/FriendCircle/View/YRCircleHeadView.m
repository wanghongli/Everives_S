//
//  YRCircleHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleHeadView.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "YRNameSexView.h"
#define kImgWHPercent 0.24
#define kDistance 5
@interface YRCircleHeadView ()
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) YRNameSexView *nameSexView;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) UIImageView *sexImg;
@end

@implementation YRCircleHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.image = [UIImage imageNamed:@"backImg"];
//        [self buildUI];
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
    [_imgView sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = w/2;
    
    _nameSexView = [[YRNameSexView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)+kDistance, kScreenWidth, [KUserManager.name sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)].height)];
    [self addSubview:_nameSexView];
    [_nameSexView nameWith:KUserManager.name sex:[KUserManager.gender boolValue]];
    
    _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameSexView.frame)+kDistance, kScreenWidth, 20)];
    _signLabel.text = @"玉祥驾校学车就是好，有实惠又快又好。";
    _signLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_signLabel];
    _signLabel.font = [UIFont systemFontOfSize:12];
    
}
-(void)setUserMsgWithName:(NSString *)name gender:(BOOL)gender sign:(NSString *)sign
{
    CGFloat w = kImgWHPercent*kScreenWidth;
    CGFloat x = 0;
    CGFloat y = self.height*0.3;
    CGFloat h = w;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    [self addSubview:_imgView];
//    _imgView.center = CGPointMake(kScreenWidth/2, (self.frame.size.height-w)/3+w/2);
    _imgView.center = CGPointMake(kScreenWidth/2, _imgView.center.y);

    [_imgView sd_setImageWithURL:[NSURL URLWithString:KUserManager.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = w/2;
    
    _nameSexView = [[YRNameSexView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgView.frame)+kDistance, kScreenWidth, [KUserManager.name sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)].height)];
    [self addSubview:_nameSexView];
    [_nameSexView nameWith:name sex:gender];
    
    _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameSexView.frame)+kDistance, kScreenWidth, 20)];
//    _signLabel.text = @"玉祥驾校学车就是好，有实惠又快又好。";
    _signLabel.text = sign;
    _signLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_signLabel];
    _signLabel.font = [UIFont systemFontOfSize:12];
}
-(void)setHeadImgUrl:(NSString *)headImgUrl
{
    _headImgUrl = headImgUrl;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:headImgUrl] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];

}
@end
