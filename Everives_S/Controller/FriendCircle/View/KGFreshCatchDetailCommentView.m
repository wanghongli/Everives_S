//
//  KGFreshCatchDetailCommentView.m
//  SkyFish
//
//  Created by 李洪攀 on 15/11/23.
//  Copyright © 2015年 SkyFish. All rights reserved.
//

#import "KGFreshCatchDetailCommentView.h"
#import "YRCircleComment.h"
#import "UIImageView+WebCache.h"
#import "NSString+Tools.h"


#define CZStatusCellMargin 10
#define CZNameFont [UIFont systemFontOfSize:15]
#define CZTimeFont [UIFont systemFontOfSize:12]
#define CZSourceFont CZTimeFont
#define CZTextFont [UIFont systemFontOfSize:15]
#define CZScreenW [UIScreen mainScreen].bounds.size.width

#define KLABELCOLOR kCOLOR(99, 99, 99)
@interface KGFreshCatchDetailCommentView ()
//左侧评论图片
@property (nonatomic, weak) UIImageView *leftImg;
// 头像
@property (nonatomic, weak) UIImageView *iconView;

// 昵称
@property (nonatomic, weak) UILabel *nameView;
// 时间
@property (nonatomic, weak) UILabel *timeView;
// 正文
@property (nonatomic, weak) UILabel *textView;

@property (nonatomic, weak) UIView *topLine;

@property (nonatomic, weak) UIButton *replyBtn;//回复按钮
@end

@implementation KGFreshCatchDetailCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    //左侧评论图片
    UIImageView *leftimg = [[UIImageView alloc]init];
    leftimg.image = [UIImage imageNamed:@"SNS_Detail_Comment"];
    [self addSubview:leftimg];
    _leftImg = leftimg;
    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSizeOfScreen.width, 1)];
//    view.backgroundColor = kCOLOR(230, 230, 230);
//    _topLine = view;
//    [self addSubview:_topLine];
    
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = CZNameFont;
    nameView.textColor = kCOLOR(31, 158, 240);
    [self addSubview:nameView];
    _nameView = nameView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = CZTimeFont;
    timeView.textColor = KLABELCOLOR;
    [self addSubview:timeView];
    _timeView = timeView;
    
    //回复按钮
    UIButton *reply = [[UIButton alloc]init];
    [reply addTarget:self action:@selector(replyClick:) forControlEvents:UIControlEventTouchUpInside];
    reply.titleLabel.font = CZNameFont;
    [reply setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:reply];
    _replyBtn = reply;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = CZTextFont;
    textView.textColor = kCOLOR(51, 51, 51);
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    
}

- (void)setComment:(YRCircleComment *)comment
{
    _comment = comment;
    
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
    
}
- (void)setUpData
{
    // 头像
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_comment.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    
    // 昵称
    _nameView.text = _comment.name;
    
    // 时间
    _timeView.text = [NSString intervalSinceNow:_comment.time];
    
    // 正文
    _textView.text = _comment.content;
}

- (void)setUpFrame
{
    //左侧评论图片
    _leftImg.frame = CGRectMake(CZStatusCellMargin, 0, 15, 15);
    
    // 头像
    CGFloat imageX = CGRectGetMaxX(_leftImg.frame)+CZStatusCellMargin/2;
    CGFloat imageY = CZStatusCellMargin;
    CGFloat imageWH = 35;
    _iconView.frame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    _leftImg.center = CGPointMake(CZStatusCellMargin+15/2, _iconView.center.y);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_iconView.frame) + CZStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_comment.name sizeWithFont:CZNameFont maxSize:CGSizeMake(kSizeOfScreen.width-2*nameX, MAXFLOAT)];
    _nameView.frame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textW = CZScreenW - CZStatusCellMargin - _nameView.x;
    CGSize textSize = [_comment.content sizeWithFont:CZTextFont maxSize:CGSizeMake(textW, MAXFLOAT)];
    _textView.frame = (CGRect){{_nameView.x,CGRectGetMaxY( _nameView.frame)},textSize};
    
    _replyBtn.frame = CGRectMake(_textView.x, _textView.y, textW, textSize.height);

    
    // 时间 每次有新的时间都需要计算时间frame
    CGFloat timeY = _nameView.y;
    CGSize timeSize = [_comment.time sizeWithFont:CZTimeFont maxSize:CGSizeMake(kScreenWidth, MAXFLOAT)];
    _timeView.textAlignment = NSTextAlignmentCenter;
    CGFloat timeX = kScreenWidth - 10-timeSize.width;
    
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.cornerRadius = 17.5;
    
}
+(CGFloat)detailCommentViewWith:(YRCircleComment*)comment
{
    CGFloat height;
    // 头像
    CGFloat imageX = CZStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    
    // 昵称
    CGFloat nameX = imageX+imageWH + CZStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [comment.name sizeWithFont:CZNameFont maxSize:CGSizeMake(kSizeOfScreen.width-2*nameX, MAXFLOAT)];

    // 正文
    CGFloat textX = imageX;
    CGFloat textY = nameY+nameSize.height;
    
    CGFloat textW = CZScreenW - 2 * CZStatusCellMargin;
    CGSize textSize = [comment.content sizeWithFont:CZTextFont maxSize:CGSizeMake(textW, MAXFLOAT)];
    CGRect frame3 = (CGRect){{textX,textY},textSize};
    
    height = CGRectGetMaxY(frame3) + CZStatusCellMargin/2;
    
    return height;
}
-(void)setTopLineHidden:(BOOL)topLineHidden
{
    _topLineHidden = topLineHidden;
    _topLine.hidden = topLineHidden;
}
-(void)replyClick:(UIButton *)sender
{
    if (self.replyTapClickBlock) {
        self.replyTapClickBlock(_comment);
    }
}
@end
