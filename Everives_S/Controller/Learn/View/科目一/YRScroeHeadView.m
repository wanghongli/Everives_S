//
//  YRScroeHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/5/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRScroeHeadView.h"

#define kImgW 120
#define kImgH 160
#define kToTopDestace 20
@interface YRScroeHeadView ()
@property (nonatomic, strong) UIImageView *scoreBackImg;
@property (nonatomic, strong) UILabel *yourScore;
@property (nonatomic, strong) UILabel *scoreLabel;
@end
@implementation YRScroeHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.yourScore.text = @"您的得分";
        self.scoreBackImg.image = [UIImage imageNamed:@"Learn_Grade-1_Score"];
        
    }
    return self;
}
-(void)setScroeString:(NSString *)scroeString
{
    _scroeString = scroeString;
    self.scoreLabel.text = scroeString;
}
-(UILabel *)yourScore
{
    if (!_yourScore) {
        _yourScore = [[UILabel alloc]initWithFrame:CGRectMake(0, kToTopDestace, kScreenWidth, kToTopDestace)];
        _yourScore.textAlignment = NSTextAlignmentCenter;
        _yourScore.font = kFontOfLetterBig;
        _yourScore.textColor = kCOLOR(51, 51, 51);
        [self addSubview:_yourScore];
    }
    
    return _yourScore;
}
-(UIImageView *)scoreBackImg
{
    if (!_scoreBackImg) {
        _scoreBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-kImgW/2, CGRectGetMaxY(self.yourScore.frame)+kToTopDestace/2, kImgW, kImgH)];
        [self addSubview:_scoreBackImg];
    }
    return _scoreBackImg;
}
-(UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _scoreBackImg.width, _scoreBackImg.width)];
        _scoreLabel.font = kFontOfSize(30);
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [_scoreBackImg addSubview:_scoreLabel];
        
    }
    return _scoreLabel;
}
@end
