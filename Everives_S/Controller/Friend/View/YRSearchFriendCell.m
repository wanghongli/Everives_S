//
//  YRSearchFriendCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSearchFriendCell.h"

@implementation YRSearchFriendCell

- (void)awakeFromNib {
    // Initialization code
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = 25;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
