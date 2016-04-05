//
//  YRMyPracticeView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMyPracticeView.h"

#import "YRFMDBObj.h"
@interface YRMyPracticeView ()

@property (nonatomic, weak) UILabel *fristNum;
@property (nonatomic, weak) UILabel *firstLabel;

@property (nonatomic, weak) UILabel *secondNum;
@property (nonatomic, weak) UILabel *secondLabel;

@property (nonatomic, weak) UILabel *thirdNum;
@property (nonatomic, weak) UILabel *thirdLabel;

@end
@implementation YRMyPracticeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    //未做题
    UILabel *firstnum = [[UILabel alloc]init];
    firstnum.font = kFontOfSize(30);
    firstnum.textAlignment = NSTextAlignmentCenter;
    firstnum.textColor = [UIColor lightGrayColor];
    [self addSubview:firstnum];
    _fristNum = firstnum;
    
    UILabel *fristlabel = [[UILabel alloc]init];
    fristlabel.font = kFontOfSize(14);
    fristlabel.textAlignment = NSTextAlignmentCenter;
    fristlabel.textColor = kCOLOR(152, 152, 152);
    fristlabel.text = @"未做题";
    [self addSubview:fristlabel];
    _firstLabel = fristlabel;
    
    //错题
    UILabel *secondtnum = [[UILabel alloc]init];
    secondtnum.font = kFontOfSize(30);
    secondtnum.textAlignment = NSTextAlignmentCenter;
    secondtnum.textColor = [UIColor redColor];
    [self addSubview:secondtnum];
    _secondNum = secondtnum;
    
    UILabel *secondlabel = [[UILabel alloc]init];
    secondlabel.font = kFontOfSize(14);
    secondlabel.textAlignment = NSTextAlignmentCenter;
    secondlabel.textColor = kCOLOR(152, 152, 152);
    secondlabel.text = @"错题数";
    [self addSubview:secondlabel];
    _secondLabel = secondlabel;
    
    //正确题数
    UILabel *thirddtnum = [[UILabel alloc]init];
    thirddtnum.font = kFontOfSize(30);
    thirddtnum.textAlignment = NSTextAlignmentCenter;
    thirddtnum.textColor = [UIColor greenColor];
    [self addSubview:thirddtnum];
    _thirdNum = thirddtnum;
    
    UILabel *thirdlabel = [[UILabel alloc]init];
    thirdlabel.font = kFontOfSize(14);
    thirdlabel.textAlignment = NSTextAlignmentCenter;
    thirdlabel.textColor = kCOLOR(152, 152, 152);
    thirdlabel.text = @"正确题数";
    [self addSubview:thirdlabel];
    _thirdLabel = thirdlabel;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat weight = kScreenWidth/3;
    CGSize numSize = [@"763" sizeWithFont:kFontOfSize(30) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize labelSize = [@"未做题" sizeWithFont:kFontOfSize(14) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    _fristNum.frame = CGRectMake(0, 0, weight, numSize.height);
    _firstLabel.frame = CGRectMake(0, CGRectGetMaxY(_fristNum.frame), weight, labelSize.height);
    
    _secondNum.frame = CGRectMake(CGRectGetMaxX(_firstLabel.frame), 0, weight, numSize.height);
    _secondLabel.frame = CGRectMake(_secondNum.x, CGRectGetMaxY(_fristNum.frame), weight, labelSize.height);
    
    _thirdNum.frame = CGRectMake(CGRectGetMaxX(_secondNum.frame), 0, weight, numSize.height);
    _thirdLabel.frame = CGRectMake(_thirdNum.x, CGRectGetMaxY(_fristNum.frame), weight, labelSize.height);
    
    NSArray *array = [YRFMDBObj getErrorAlreadyAndTotalQuestionWithType:0];
    //未做过数量
    NSInteger firstInt = [array[0] integerValue] - [array[2] integerValue];
    //错题数
    NSInteger secondInt = [array[1] integerValue];
    //正确数
    NSInteger thirdInt = [array[2] integerValue] - [array[1] integerValue];
    
    _fristNum.text = [NSString stringWithFormat:@"%ld",firstInt];
    _secondNum.text = [NSString stringWithFormat:@"%ld",secondInt];
    _thirdNum.text = [NSString stringWithFormat:@"%ld",thirdInt];
}
+(CGFloat)getHeight
{
    CGSize numSize = [@"763" sizeWithFont:kFontOfSize(30) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGSize labelSize = [@"未做题" sizeWithFont:kFontOfSize(14) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    return numSize.height+labelSize.height;
}
@end
