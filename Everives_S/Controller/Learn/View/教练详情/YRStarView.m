//
//  YRStarView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//


#import "YRStarView.h"

#define kStarHW 15
#define kDistace 5
@interface YRStarView ()
@property (nonatomic, weak) UILabel *starNum;
@end
@implementation YRStarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{
    UILabel *starnum = [[UILabel alloc]init];
    starnum.font = kFontOfLetterMedium;
    starnum.textColor = [UIColor whiteColor];
    [self addSubview:starnum];
    _starNum = starnum;
    
    for (int i = 0; i<5; i++) {
        UIImageView *img = [[UIImageView alloc]init];
        [self addSubview:img];
        img.tag = i+10;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat maxX = 0;
    for (int i = 0; i<5; i++) {
        UIImageView *img = [self viewWithTag:i+10];
        img.frame = CGRectMake((kDistace+kStarHW)*i, (self.height - kStarHW)/2, kStarHW, kStarHW);
        maxX = CGRectGetMaxX(img.frame);
    }
    
    CGSize starSize = [@"4.0" sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _starNum.frame = CGRectMake(maxX+kDistace, 0, starSize.width, self.height);
}

-(void)setStarNu:(NSInteger)starNu
{
    _starNu = starNu;
    NSString *string = [NSString stringWithFormat:@"%.1f",(CGFloat)starNu];
    _starNum.text = string;
    CGFloat maxX = 0;
    for (int i = 0; i<5; i++) {
        
        UIImageView *img = [self viewWithTag:i+10];
        if (i<starNu) {
            [img setImage:[UIImage imageNamed:@"Neig_Coach_StaOrg"]];
        }else
            [img setImage:[UIImage imageNamed:@"Neig_Coach_StaGre"]];
        maxX = CGRectGetMaxX(img.frame);
    }
}

+(CGFloat)getStarViewWight
{
    CGFloat wight = (kDistace+kStarHW)*5;

    CGSize starSize = [@"4.0" sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    wight+=starSize.width;
    return wight;
}
@end
