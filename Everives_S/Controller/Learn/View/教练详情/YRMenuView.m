//
//  YRMenuView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//


#import "YRMenuView.h"

#define kDistace 5
@interface YRMenuView ()
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UILabel *yearLabel;
@property (nonatomic, weak) UILabel *gradeLabel;
@property (nonatomic, weak) UILabel *numbPeopleLabel;

@end
@implementation YRMenuView

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
    [self addSubview:backview];
    _backView = backview;
    
    _yearLabel = [self buildLabel];
    _gradeLabel = [self buildLabel];
    _numbPeopleLabel = [self buildLabel];
}

-(UILabel *)buildLabel
{
    UILabel *yearlabel = [[UILabel alloc]init];
    yearlabel.font = kFontOfLetterSmall;
    yearlabel.textColor = [UIColor whiteColor];
    yearlabel.textAlignment = NSTextAlignmentCenter;
    [_backView addSubview:yearlabel];
    return yearlabel;
}
-(void)setMenuArray:(NSArray *)menuArray
{
    _menuArray = menuArray;
    
    CGSize yearSize = [menuArray[0] sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _yearLabel.frame = CGRectMake(0, 0, yearSize.width+2*kDistace, yearSize.height);
    _yearLabel.text = menuArray[0];
    _yearLabel.backgroundColor = kCOLOR(217, 85, 140);
    
    CGSize gradeSize = [menuArray[1] sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _gradeLabel.frame = CGRectMake(CGRectGetMaxX(_yearLabel.frame)+kDistace, 0, gradeSize.width+2*kDistace, gradeSize.height);
    _gradeLabel.text = menuArray[1];
    _gradeLabel.backgroundColor = kCOLOR(185, 99, 168);
    
    CGSize numPeopleSize = [menuArray[2] sizeWithFont:kFontOfLetterMedium maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _numbPeopleLabel.frame = CGRectMake(CGRectGetMaxX(_gradeLabel.frame)+kDistace, 0, numPeopleSize.width+2*kDistace, numPeopleSize.height);
    _numbPeopleLabel.text = menuArray[2];
    _numbPeopleLabel.backgroundColor = kCOLOR(51, 51, 51);
    
    _backView.frame = CGRectMake(0, 0, CGRectGetMaxX(_numbPeopleLabel.frame), _numbPeopleLabel.height);
    _backView.center = CGPointMake(self.width/2, self.height/2);
    
    [self getCorner:_yearLabel];
    [self getCorner:_gradeLabel];
    [self getCorner:_numbPeopleLabel];
}
-(void)getCorner:(UIView *)view
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = view.height/2;
}
@end
