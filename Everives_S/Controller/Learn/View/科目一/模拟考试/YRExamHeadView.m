//
//  YRExamHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamHeadView.h"
#import "NSString+Tools.h"

#define kDistance 20
@interface YRExamHeadView ()
@property (nonatomic, weak) UILabel *titleLabel;
@end
@implementation YRExamHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.numberOfLines = 0;
    titlelabel.font = kFontOfLetterBig;
    titlelabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titlelabel];
    _titleLabel = titlelabel;
}
-(void)setQues:(YRQuestionObject *)ques
{
    _ques = ques;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",ques.id,ques.content];
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistance, MAXFLOAT)];
    _titleLabel.frame = CGRectMake(kDistance, kDistance/2, titleSize.width, titleSize.height);
    _titleLabel.text = titleString;
}
+(CGFloat)examHeadViewHeight:(YRQuestionObject *)ques
{
    CGFloat height;
    height = kDistance;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",ques.id,ques.content];
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistance, MAXFLOAT)];
    height+=titleSize.height;
    return height;
}
@end
