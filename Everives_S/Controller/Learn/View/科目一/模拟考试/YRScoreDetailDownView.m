//
//  YRScoreDetailDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRScoreDetailDownView.h"
#define kDistace 10
@interface YRScoreDetailDownView ()

@property (nonatomic, weak) UIButton *checkError;
@property (nonatomic, weak) UIButton *shareScore;

@end
@implementation YRScoreDetailDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{

    UIButton *checkerror = [[UIButton alloc]init];
    [checkerror setTitle:@"查看错题" forState:UIControlStateNormal];
    [checkerror setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkerror.backgroundColor = kCOLOR(77, 77, 77);
    [checkerror addTarget:self action:@selector(scroeDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    checkerror.tag = 11;
    [self addSubview:checkerror];
    _checkError = checkerror;
    
    UIButton *sharescore = [[UIButton alloc]init];
    [sharescore setTitle:@"分享成绩" forState:UIControlStateNormal];
    [sharescore setTitleColor:kCOLOR(77, 77, 77) forState:UIControlStateNormal];
    [sharescore addTarget:self action:@selector(scroeDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sharescore.tag = 12;
    [self addSubview:sharescore];
    _shareScore = sharescore;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat weight = (self.width-kDistace)/3;
    _checkError.frame = CGRectMake(weight/2, 0, weight, self.height);
    _shareScore.frame = CGRectMake(CGRectGetMaxX(_checkError.frame)+kDistace, 0, weight, self.height);
    [self setLayerWithView:_checkError];
    [self setLayerWithView:_shareScore];
}
- (void)setLayerWithView:(UIButton *)btn
{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.height/2;
    btn.layer.borderColor = kCOLOR(77, 77, 77).CGColor;
    btn.layer.borderWidth = 1;
}
-(void)scroeDownBtnClick:(UIButton *)sender
{
    [self.delegate scoreDetailDownViewBtnClick:sender.tag-10];
}
@end
