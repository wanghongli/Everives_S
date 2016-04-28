//
//  YRActivityTableViewCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRActivityTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation YRActivityTableViewCell

- (void)awakeFromNib {
    _titleL.textColor = kYRBlackTextColor;
    _contentL.textColor = kYRLightTextColor;
    _contentL.numberOfLines = 0;
    _contentL.lineBreakMode = NSLineBreakByWordWrapping;
    _dateL.textColor = kYRBlackTextColor;
}

-(void)setModel:(YRActivityModel *)model{
    [_picView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    _titleL.text = model.title;
    _contentL.text = model.intro;
    _dateL.text = model.begintime;
}

@end
