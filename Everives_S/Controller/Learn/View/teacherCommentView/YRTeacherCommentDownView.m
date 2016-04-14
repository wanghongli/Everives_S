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
    
    for (int i = 0; i<9; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        img.tag = i+30;
        [self addSubview:img];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize contentSize = [_detailObj.content sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    _contentLabel.frame = CGRectMake(kDistace, kDistace, kScreenWidth-2*kDistace, contentSize.height);
    _contentLabel.text = _detailObj.content;
    
    CGFloat maxY = 0;
    if (_detailObj.pics.count) {
        for (int i = 0; i<9; i++) {
            UIImageView *img = [self viewWithTag:i+30];
            if (i<_detailObj.pics.count) {
                img.hidden = NO;
                CGFloat x = i%3;
                CGFloat y = i/3;
                CGFloat distace = 5;
                img.frame = CGRectMake(kDistace + x*(kPICTURE_HW+distace), CGRectGetMaxY(_contentLabel.frame)+kDistace+y*(kPICTURE_HW+distace), kPICTURE_HW, kPICTURE_HW);
                [img sd_setImageWithURL:[NSURL URLWithString:_detailObj.pics[i]] placeholderImage:[UIImage imageNamed:@""]];
                maxY = CGRectGetMaxY(img.frame);
            }else{
                img.hidden = YES;
            }
        }
    }else
        maxY = CGRectGetMaxY(_contentLabel.frame);
    
    CGSize timeSize = [[NSString intervalSinceNow:_detailObj.time] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    _timeLabel.frame = CGRectMake(kDistace, maxY+kDistace, kScreenWidth-2*kDistace, timeSize.height);
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
    
    if (detailObj.pics.count) {
        CGFloat y = detailObj.pics.count/3;
        height = height + y*(kPICTURE_HW+5) + kPICTURE_HW;
        height+=kDistace;
    }
    
    CGSize timeSize = [[NSString intervalSinceNow:detailObj.time] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistace, CGFLOAT_MAX)];
    height+=timeSize.height;
    height+=kDistace;

    return height;
}
@end
