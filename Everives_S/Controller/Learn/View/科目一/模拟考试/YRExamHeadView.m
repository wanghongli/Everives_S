//
//  YRExamHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamHeadView.h"
#import "NSString+Tools.h"
#import "UIImageView+WebCache.h"

#define kDistance 20
@interface YRExamHeadView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *topLine;
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
    
    UIImageView *imgview = [[UIImageView alloc]init];
    [self addSubview:imgview];
    _imgView = imgview;
    
    UIView *topline = [[UIView alloc]init];
    topline.backgroundColor = kCOLOR(241, 241, 241);
    [self addSubview:topline];
    _topLine = topline;
}
-(void)setQues:(YRQuestionObject *)ques
{
    _ques = ques;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",ques.id,ques.content];
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistance, MAXFLOAT)];
    _titleLabel.frame = CGRectMake(kDistance, kDistance, titleSize.width, titleSize.height);
    _titleLabel.text = titleString;
    
    if (ques.pics.count) {
        _imgView.frame = CGRectMake(kDistance*2, CGRectGetMaxY(_titleLabel.frame)+kDistance, kScreenWidth-4*kDistance, (kScreenWidth-4*kDistance)/2);
        [_imgView sd_setImageWithURL:ques.pics[0] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        _topLine.frame = CGRectMake(0, CGRectGetMaxY(_imgView.frame)+kDistance-1, kScreenWidth, 1);
        _imgView.hidden = NO;
    }else{
        _imgView.hidden = YES;
        _topLine.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+kDistance-1, kScreenWidth, 1);
    }
}
+(CGFloat)examHeadViewHeight:(YRQuestionObject *)ques
{
    CGFloat height;
    height = kDistance*2;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",ques.id,ques.content];
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistance, MAXFLOAT)];
    if (ques.pics.count) {
        height+= (kScreenWidth-4*kDistance)/2;
        height+=kDistance;
    }
    height+=titleSize.height;
    return height;
}
@end
