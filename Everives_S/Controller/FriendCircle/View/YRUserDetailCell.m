//
//  YRUserDetailCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserDetailCell.h"

#define  kTitleColor kCOLOR(118, 118, 118)
#define kdistance 10
@interface YRUserDetailCell ()
@property (nonatomic, weak) UILabel *mainLabel;
@property (nonatomic, weak) UILabel *descriLabel;
@property (nonatomic, weak) UIImageView *signImg;
@end
@implementation YRUserDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI
{
    UILabel *mainlabel = [[UILabel alloc]init];
    mainlabel.textAlignment = NSTextAlignmentLeft;
    mainlabel.textColor = KDarkColor;
    mainlabel.font = kFontOfLetterBig;
    [self addSubview:mainlabel];
    _mainLabel = mainlabel;
    
    UILabel *descrilabel = [[UILabel alloc]init];
    descrilabel.textAlignment = NSTextAlignmentCenter;
    descrilabel.textColor = KDarkColor;
    descrilabel.font = kFontOfLetterMedium;
    descrilabel.numberOfLines = 0;
    [self addSubview:descrilabel];
    _descriLabel = descrilabel;
    
    UIImageView *signimg = [[UIImageView alloc]init];
    signimg.image = [UIImage imageNamed:@"Neig_Coach_Field"];
    [self addSubview:signimg];
    _signImg = signimg;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _mainLabel.frame = CGRectMake(2*kdistance, kdistance, titleSize.width, titleSize.height);
    _mainLabel.text = titleString;
    
}
-(void)setDescriString:(NSString *)descriString
{
    _descriString = descriString;
    CGSize descriSize = [descriString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-CGRectGetMaxX(_mainLabel.frame)-3*kdistance, MAXFLOAT)];
    CGFloat labelWidth = descriSize.width;
    if (![_mainLabel.text containsString:@"驾友圈"]) {
        if ([_mainLabel.text isEqualToString:@"进度"]) {
            labelWidth+=2*kdistance;
            _descriLabel.backgroundColor = kCOLOR(31, 159, 240);
            _descriLabel.textColor = [UIColor whiteColor];
            _descriLabel.frame = CGRectMake(CGRectGetMaxX(_mainLabel.frame)+kdistance, _mainLabel.y, labelWidth, descriSize.height);
            _descriLabel.layer.masksToBounds = YES;
            _descriLabel.layer.cornerRadius = _descriLabel.height/2;
        }else{
            _descriLabel.frame = CGRectMake(CGRectGetMaxX(_mainLabel.frame)+kdistance, _mainLabel.y, labelWidth, descriSize.height);
            _descriLabel.textColor = KDarkColor;
            _descriLabel.backgroundColor = [UIColor clearColor];
        }
        _descriLabel.text = descriString;
        _signImg.hidden = YES;
    }else{
        _signImg.hidden = NO;
        _signImg.frame = CGRectMake(CGRectGetMaxX(_mainLabel.frame)+kdistance/2, _mainLabel.y, _mainLabel.height, _mainLabel.height);
    }
}
+(CGFloat)userDetailCellGetHeightWith:(NSString *)descriString
{
    CGFloat cellHeight = 2*kdistance;
    CGSize titleSize = [@"年龄" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (descriString) {
        CGSize descriSize = [descriString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-titleSize.width-5*kdistance, MAXFLOAT)];
        cellHeight +=descriSize.height;
    }else{
        cellHeight +=titleSize.height;
    }
    
    return cellHeight;
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
