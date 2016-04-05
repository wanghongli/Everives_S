//
//  YRExamScorePercentView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamScorePercentView.h"

#define kFirstString @"您的排名为"
@interface YRExamScorePercentView ()

@property (nonatomic, weak) UILabel *firstString;
@property (nonatomic, weak) UILabel *middleString;
@property (nonatomic, weak) UILabel *lastString;

@end
@implementation YRExamScorePercentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{

    UILabel *firststring = [[UILabel alloc]init];
    firststring.font = kFontOfLetterMedium;
    firststring.textAlignment = NSTextAlignmentLeft;
    firststring.textColor = kCOLOR(51, 51, 51);
    firststring.text = kFirstString;
    [self addSubview:firststring];
    _firstString = firststring;
    
    UILabel *middlestring = [[UILabel alloc]init];
    middlestring.font = kFontOfSize(30);
    middlestring.textColor = [UIColor blackColor];
    middlestring.textAlignment = NSTextAlignmentCenter;
    [self addSubview:middlestring];
    _middleString = middlestring;
    
    UILabel *laststring = [[UILabel alloc]init];
    laststring.text = @"%";
    laststring.textAlignment = NSTextAlignmentCenter;
    laststring.font = kFontOfLetterMedium;
    laststring.textColor = kCOLOR(51, 51, 51);
    [self addSubview:laststring];
    _lastString = laststring;

}
-(void)setHeadString:(NSString *)headString
{
    _headString = headString;
}
-(void)setScoreString:(NSString *)scoreString
{
    _scoreString = scoreString;
    _middleString.text = scoreString;
    CGSize middleSize = [scoreString sizeWithFont:kFontOfSize(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGSize firstSize = [_headString sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _firstString.frame = CGRectMake(0, middleSize.height-firstSize.height, firstSize.width, firstSize.height);
    _firstString.text = _headString;
    _middleString.frame = CGRectMake(CGRectGetMaxX(_firstString.frame), 0, middleSize.width, middleSize.height);
    CGSize lastSize = [@"%" sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _lastString.frame = CGRectMake(CGRectGetMaxX(_middleString.frame), _firstString.y, lastSize.width, lastSize.height);
    
    
}
+(CGFloat)getExamScorePercentViewHeight:(NSString *)scoreString  withHeadString:(NSString *)headString
{
    CGFloat weight = 0;
    CGSize middleSize = [scoreString sizeWithFont:kFontOfSize(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    weight+=middleSize.width;
    CGSize firstSize = [headString sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    weight+=firstSize.width;
    CGSize lastSize = [@"%" sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    weight+=lastSize.width;
    return weight;
}
@end
