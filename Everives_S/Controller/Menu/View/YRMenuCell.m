//
//  YRMenuCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/13.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMenuCell.h"

@implementation YRMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.contentView.frame];
    self.selectedBackgroundView.backgroundColor = kCOLOR(245, 245, 245);
}

@end
