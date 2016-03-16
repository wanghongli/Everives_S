//
//  YRSchoolTableCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSchoolTableCell.h"
#import "YRStarsView.h"
@implementation YRSchoolTableCell

- (void)awakeFromNib {
    YRStarsView *star = [[YRStarsView alloc] initWithFrame:CGRectMake(95, 30, 120, 30) score:4 starWidth:20 intervel:3 needLabel:YES];
    [self addSubview:star];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
