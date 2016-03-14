//
//  YRSchoolTableCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSchoolTableCell.h"

@implementation YRSchoolTableCell

- (void)awakeFromNib {
    // Initialization code
    for (NSInteger i = 0; i<5; i++) {
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(95+35*i, 30, 30, 30)];
        if (i<4) {
            star.image = [UIImage imageNamed:@"Neig_Coach_StaOrg"];
        }else{
            star.image = [UIImage imageNamed:@"Neig_Coach_StaGre"];
        }
        [self addSubview:star];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
