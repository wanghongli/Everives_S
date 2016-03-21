//
//  YRExamDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamDownView.h"
#import "NSString+Tools.h"

#define  kDistance 10
@interface YRExamDownView ()
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UILabel *anayLabel;
@property (nonatomic, weak) UILabel *answerLabel;
@end
@implementation YRExamDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    UIView *backview = [[UIView alloc]init];
    backview.backgroundColor = kCOLOR(250, 250, 250);
    [self addSubview:backview];
    _backView = backview;
    
    UILabel *anaylabel = [[UILabel alloc]init];
    anaylabel.numberOfLines = 0;
    anaylabel.font = kFontOfLetterBig;
    [_backView addSubview:anaylabel];
    _anayLabel = anaylabel;
    
    UILabel *answerlabel = [[UILabel alloc]init];
    answerlabel.font = kFontOfLetterBig;
    [_backView addSubview:answerlabel];
    _answerLabel = answerlabel;
}
-(void)setAnayString:(NSString *)anayString
{
    _anayString = anayString;
    
    CGSize answerSize = [@"答案：正确" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(self.width-2*kDistance, MAXFLOAT)];
    _answerLabel.frame = CGRectMake(kDistance, kDistance, self.width-4*kDistance, answerSize.height);
    _answerLabel.text = @"答案：正确";
    
    NSString *analyseMsg = [NSString stringWithFormat:@"解析：%@",@"拉克丝的减肥啦手机登陆高价收购的离开家阿里；加疯了快接啊收到了；发送过来；卡；诶见gas离开房间艾丝凡看见了的法律是京东方拉斯加咖喱块十几个IE阿斯顿"];
    CGSize analyseSize = [analyseMsg sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(_answerLabel.width, MAXFLOAT)];
    _anayLabel.frame = CGRectMake(kDistance, CGRectGetMaxY(_answerLabel.frame), analyseSize.width, analyseSize.height);
    _anayLabel.text = analyseMsg;
    
    _backView.frame = CGRectMake(kDistance, 0, kScreenWidth-2*kDistance, CGRectGetMaxY(_anayLabel.frame)+kDistance);
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _backView.layer.borderWidth = 1;
}
+(CGFloat)examDownViewGetHeight:(NSString *)analyseString
{
    CGFloat height = kDistance;
    
    CGSize answerSize = [@"答案：正确" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-4*kDistance, MAXFLOAT)];
    height+=answerSize.height;
    
    CGSize analyseSize = [[NSString stringWithFormat:@"解析：%@",@"拉克丝的减肥啦手机登陆高价收购的离开家阿里；加疯了快接啊收到了；发送过来；卡；诶见gas离开房间艾丝凡看见了的法律是京东方拉斯加咖喱块十几个IE阿斯顿"] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(answerSize.width, MAXFLOAT)];
    height+=analyseSize.height;
    height+=kDistance;
    
    return height;
}
-(void)setQuestOb:(YRQuestionObject *)questOb
{
    _questOb = questOb;
    NSString *anserString;
    if (questOb.option.count && [questOb.option[0] length]) {
        anserString = [NSString stringWithFormat:@"答案：%@",[@[@"A",@"B",@"C",@"D"] objectAtIndex:questOb.answer]];
    }else{
        anserString = questOb.answer ? @"答案：错误":@"答案：正确";
    }
    CGSize answerSize = [anserString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(self.width-2*kDistance, MAXFLOAT)];
    _answerLabel.frame = CGRectMake(kDistance, kDistance, self.width-4*kDistance, answerSize.height);
    _answerLabel.text = anserString;
    
    NSString *analyseMsg = [NSString stringWithFormat:@"解析：%@",questOb.analy];
    CGSize analyseSize = [analyseMsg sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(_answerLabel.width, MAXFLOAT)];
    _anayLabel.frame = CGRectMake(kDistance, CGRectGetMaxY(_answerLabel.frame), analyseSize.width, analyseSize.height);
    _anayLabel.text = analyseMsg;
    
    _backView.frame = CGRectMake(kDistance, 0, kScreenWidth-2*kDistance, CGRectGetMaxY(_anayLabel.frame)+kDistance);
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _backView.layer.borderWidth = 1;
    
    
}
+(CGFloat)examDownViewHeight:(YRQuestionObject *)analyseString
{
    CGFloat height = kDistance;
    
    CGSize answerSize = [@"答案：正确" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-4*kDistance, MAXFLOAT)];
    height+=answerSize.height;
    
    CGSize analyseSize = [[NSString stringWithFormat:@"解析：%@",analyseString.analy] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(answerSize.width, MAXFLOAT)];
    height+=analyseSize.height;
    height+=kDistance;
    
    return height;
}
@end
