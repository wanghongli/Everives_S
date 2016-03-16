//
//  YRReservationCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationCell.h"
@interface YRReservationCell()

@property (weak, nonatomic) IBOutlet UIImageView *avatar;

@end
@implementation YRReservationCell

- (void)awakeFromNib {
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = 45;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
