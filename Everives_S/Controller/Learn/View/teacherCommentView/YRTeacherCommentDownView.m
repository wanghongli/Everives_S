//
//  YRTeacherCommentDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/13.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherCommentDownView.h"
#define kDistace 10
@interface YRTeacherCommentDownView ()
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@end
@implementation YRTeacherCommentDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = kFontOfLetterBig;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:contentLabel];
    _contentLabel = contentLabel;
    
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = kFontOfLetterMedium;
    timeLabel.textColor = [UIColor blackColor];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:timeLabel];
    _timeLabel = timeLabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentSize = [_detailObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    _contentLabel.frame = CGRectMake(kDistace, kDistace, kScreenWidth-2*kDistace, contentSize.height);
    _contentLabel.text = _detailObj.content;
    
    CGSize timeSize = [[NSString intervalSinceNow:_detailObj.time] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    _timeLabel.frame = CGRectMake(kDistace, CGRectGetMaxY(_contentLabel.frame)+kDistace, kScreenWidth-2*kDistace, timeSize.height);
    _timeLabel.text = [NSString intervalSinceNow:_detailObj.time];
}
-(void)setDetailObj:(YRTeacherCommentDetailObj *)detailObj
{
    _detailObj = detailObj;
}
+ (CGFloat)getTeacherCommentDownViewObj:(YRTeacherCommentDetailObj *)detailObj
{
    CGFloat height;
    height+=kDistace;
    CGSize contentSize = [detailObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    height+=contentSize.height;
    height+=kDistace;
    CGSize timeSize = [[NSString intervalSinceNow:detailObj.time] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    height+=timeSize.height;
    height+=kDistace;

    return height;
}
@end
