//
//  YRStudentTableCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRStudentTableCell.h"
#import "YRUserStatus.h"
#import "DistanceToolFuc.h"
#import <UIImageView+WebCache.h>
@implementation YRStudentTableCell

- (void)awakeFromNib {
    // Initialization code
    _name.font = kFontOfLetterBig;
    _distance.textColor = kTextlightGrayColor;
    _sign.textColor = kTextlightGrayColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YRUserStatus *)model{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:kUSERAVATAR_PLACEHOLDR]];
    _name.text = model.name;
    _sign.text = model.sign.length != 0?model.sign:@"这个人很懒，什么都没有留下~";
    double dis = [DistanceToolFuc calculateDistanceWithLongitude1:[model.lng doubleValue] Laititude1:[model.lat doubleValue] Longitude2:[KUserLocation.longitude doubleValue] Laititude2:[KUserLocation.latitude doubleValue]];
    if (dis>1000000) {
        _distance.text = @"距离未知";
    }else if (dis>1000) {
        _distance.text = [NSString stringWithFormat:@"距离%.1fkm",dis/1000];
    }else{
        _distance.text = [NSString stringWithFormat:@"距离%.0fm",dis];
    }
    if ([model.gender isEqualToString:@"0"]) {
        _gender.image = [UIImage imageNamed:@"Neighborhood_Coach_male"];
    }else{
        _gender.image = [UIImage imageNamed:@"Neighborhood_Coach_Female"];
    }
}
@end
