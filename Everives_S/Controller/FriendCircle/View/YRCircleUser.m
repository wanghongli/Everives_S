//
//  YRCircleUser.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleUser.h"
#import "YRCirclePhoto.h"
#import "UIImageView+WebCache.h"
#import "YRCircleCellViewModel.h"
#import "YRWeibo.h"
#define CZStatusCellMargin 10
#define CZNameFont [UIFont systemFontOfSize:13]
#define CZTimeFont [UIFont systemFontOfSize:12]
#define CZSourceFont CZTimeFont
#define CZTextFont [UIFont systemFontOfSize:15]
#define CZScreenW [UIScreen mainScreen].bounds.size.width
@interface YRCircleUser ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;

// 昵称
@property (nonatomic, weak) UILabel *nameView;
// 时间
@property (nonatomic, weak) UILabel *timeView;
//分割线
@property (nonatomic, weak) UIView *seperaterLine;
// 正文
@property (nonatomic, weak) UILabel *textView;
// 配图
@property (nonatomic, weak) YRCirclePhoto *photosView;

@end
@implementation YRCircleUser

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self setUpAllChildView];
    }
    return self;
}

- (void)setUpAllChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.userInteractionEnabled = YES;
    // 添加点按手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [iconView addGestureRecognizer:tap];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CZNameFont;
    nameView.textColor = kCOLOR(47, 50, 50);
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = CZTimeFont;
    timeView.textColor = [UIColor colorWithRed:154/255.0 green:155/255.0 blue:156/255.0 alpha:1];
    [self addSubview:timeView];
    _timeView = timeView;
    
    //分割线
    UIView *seperaterline = [[UIView alloc]init];
    seperaterline.backgroundColor = kCOLOR(241, 241, 241);
    [self addSubview:seperaterline];
    _seperaterLine = seperaterline;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.numberOfLines = 0;
    textView.textColor = kCOLOR(28, 28, 28);
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    YRCirclePhoto *photosView = [[YRCirclePhoto alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}
#pragma mark - 头像被点击
-(void)tap:(UITapGestureRecognizer*)sender
{
    [self.delegate userIconClick];
}
-(void)setStatusF:(YRCircleCellViewModel *)statusF
{
    _statusF = statusF;
    
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
}

- (void)setUpFrame
{
    // 头像
    _iconView.frame = _statusF.originalIconFrame;
    
    // 昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    // 时间 每次有新的时间都需要计算时间frame
    YRWeibo *status = _statusF.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY( _nameView.frame) + CZStatusCellMargin * 0.5;
    //    CGSize timeSize = [status.time sizeWithFont:CZTimeFont];
    CGSize timeSize = [[NSString intervalSinceNow:status.time] sizeWithFont:CZTimeFont maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    
    _seperaterLine.frame = CGRectMake(0, CGRectGetMaxY(_timeView.frame)+5, self.frame.size.width-20, 1);
    
    // 正文
    _textView.frame = _statusF.originalTextFrame;
    
    // 配图
    _photosView.frame = _statusF.originalPhotosFrame;
    
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = 17.5;
    _iconView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _iconView.layer.borderWidth = 1;
}
-(void)setLineBool:(BOOL)lineBool
{
    _lineBool = lineBool;
    _seperaterLine.hidden = lineBool;
}
- (void)setUpData
{
    YRWeibo *status = _statusF.status;
    // 头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:status.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    
    // 昵称
    _nameView.textColor = [UIColor blackColor];
    if (status.name.length) {
        _nameView.text = status.name;
    }else
        _nameView.text = @"玉祥驾校";
    
    // 时间
    _timeView.text = [NSString intervalSinceNow:status.time];//status.time
    
    // 正文
    _textView.text = status.content;
    
    // 配图
    _photosView.pic_urls = status.pics;
    _photosView.circleModel = status;
}
@end
