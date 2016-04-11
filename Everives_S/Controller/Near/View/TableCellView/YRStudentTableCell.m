//
//  YRStudentTableCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRStudentTableCell.h"
#import "YRUserStatus.h"
#import <UIImageView+WebCache.h>
@implementation YRStudentTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YRUserStatus *)model{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _name.text = model.name;
    _sign.text = model.sign;
    _distance.text = @"距离";
    _distance.textColor = kTextlightGrayColor;
    _sign.textColor = kTextlightGrayColor;
    if ([model.gender isEqualToString:@"0"]) {
        _gender.image = [UIImage imageNamed:@"Neighborhood_Coach_male"];
    }else{
        _gender.image = [UIImage imageNamed:@"Neighborhood_Coach_Female"];
    }
}
@end
