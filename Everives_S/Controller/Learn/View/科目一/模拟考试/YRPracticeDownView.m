//
//  YRPracticeDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPracticeDownView.h"
#include "NSString+Tools.h"
#define kDistace 10
@interface YRPracticeDownView ()
@property (nonatomic, weak) UIButton *collectBtn;
@property (nonatomic, weak) UILabel *questNumb;
@property (nonatomic, weak) UIButton *doneBtn;
@property (nonatomic, weak) UIView *topLine;
@end
@implementation YRPracticeDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{
    //收藏
    UIButton *collectbtn = [[UIButton alloc]init];
    [collectbtn setImage:[UIImage imageNamed:@"Learn_CollectionHollow"] forState:UIControlStateNormal];
    [collectbtn setImage:[UIImage imageNamed:@"Learn_CollectionBlack"] forState:UIControlStateSelected];
    [collectbtn addTarget:self action:@selector(downViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    collectbtn.tag = 11;
    [self addSubview:collectbtn];
    _collectBtn = collectbtn;
    
    //当前题数和总题数
    UILabel *questNumb = [[UILabel alloc]init];
    questNumb.font = kFontOfLetterBig;
    questNumb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:questNumb];
    _questNumb = questNumb;
    
    //交卷
    UIButton *donebtn = [[UIButton alloc]init];
    [donebtn setTitle:@"交卷" forState:UIControlStateNormal];
    donebtn.titleLabel.font = kFontOfLetterBig;
    [donebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [donebtn addTarget:self action:@selector(downViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    donebtn.tag = 12;
    [self addSubview:donebtn];
    _doneBtn = donebtn;
    
    UIView *topline = [[UIView alloc]init];
    topline.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:topline];
    _topLine = topline;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _collectBtn.frame = CGRectMake(0, 0, self.height*0.7, self.height*0.7);
    _collectBtn.center = CGPointMake(self.width/2, self.height/2);
    
    _topLine.frame = CGRectMake(0, 0, self.width, 1);
    
    CGSize doneSize = [@"交卷" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _doneBtn.frame = CGRectMake(self.width-doneSize.width-2*kDistace, 0, doneSize.width+2*kDistace, self.height);
    
    
}
-(void)setNumbString:(NSString *)numbString
{
    _numbString = numbString;
    
    CGSize numbSize = [numbString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _questNumb.frame = CGRectMake(0, 0, numbSize.width+2*kDistace, self.height);
    _questNumb.text = numbString;
    
}
-(void)downViewBtnClick:(UIButton *)sender
{
    MyLog(@"%s",__func__);
    [self.delegate praciceDownViewBtnClick:sender.tag-10 with:[NSString stringWithFormat:@"%ld",_questObj.id]];
}
-(void)setQuestObj:(YRQuestionObject *)questObj
{
    _questObj = questObj;
}
@end
