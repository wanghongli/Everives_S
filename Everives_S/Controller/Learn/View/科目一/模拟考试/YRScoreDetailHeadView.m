//
//  YRScoreDetailHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRScoreDetailHeadView.h"
@interface YRScoreDetailHeadView ()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@end
@implementation YRScoreDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{

    UIImageView *imgview = [[UIImageView alloc]init];
    imgview.image = [UIImage imageNamed:@"Learn_Grade-1_Score"];
    [self addSubview:imgview];
    _imgView = imgview;
    
    UILabel *scorelabel = [[UILabel alloc]init];
    scorelabel.textColor = [UIColor whiteColor];
    scorelabel.font = kFontOfSize(20);
    scorelabel.textAlignment = NSTextAlignmentCenter;
    [_imgView addSubview:scorelabel];
    _scoreLabel = scorelabel;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = kFontOfLetterBig;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kCOLOR(106, 106, 106);
    titleLabel.text = @"您的得分";
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _imgView.frame = CGRectMake(0, 0, self.height*0.6*_imgView.image.size.width/_imgView.image.size.height, self.height*0.65);
    _imgView.center = CGPointMake(self.width/2, self.height/2+20);
    
    _titleLabel.frame = CGRectMake(0, _imgView.y-20, self.width, 20);
    
    _scoreLabel.frame = CGRectMake(0, 0, _imgView.width, _imgView.width+5);
    _scoreLabel.text = @"93";
}

@end
