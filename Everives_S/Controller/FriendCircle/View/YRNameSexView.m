//
//  YRNameSexView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRNameSexView.h"
#import "NSString+Tools.h"
@interface YRNameSexView ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *sexImg;
@end
@implementation YRNameSexView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{
    UILabel *label = [[UILabel alloc]init];
    label.font = kFontOfLetterBig;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = kCOLOR(41, 42, 43);
    [self addSubview:label];
    _nameLabel = label;
    
    UIImageView *img = [[UIImageView alloc]init];
    [self addSubview:img];
    _sexImg = img;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)nameWith:(NSString *)name sex:(BOOL)sexBool
{
    CGSize nameSize = [name sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth/2, MAXFLOAT)];
    _nameLabel.frame = CGRectMake(self.width/2-nameSize.width/2-nameSize.height/2, 0, nameSize.width, nameSize.height);
    _nameLabel.text = name;
    
    _sexImg.frame = CGRectMake(CGRectGetMaxX(_nameLabel.frame), _nameLabel.y, nameSize.height, nameSize.height);
    if (sexBool) {
        _sexImg.image = [UIImage imageNamed:@"Neighborhood_Coach_Female"];
    }else{
        _sexImg.image = [UIImage imageNamed:@"Neighborhood_Coach_male"];
    }
}

@end
