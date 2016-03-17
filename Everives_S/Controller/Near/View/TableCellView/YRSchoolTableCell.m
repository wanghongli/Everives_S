//
//  YRSchoolTableCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSchoolTableCell.h"
#import "YRStarsView.h"
#import "YRSchoolModel.h"
@implementation YRSchoolTableCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(YRSchoolModel *)model{
    _name.text = model.name;
    _addr.text = model.address;
    _intro.text = model.intro;
    YRStarsView *star = [[YRStarsView alloc] initWithFrame:CGRectMake(_name.frame.origin.x, 28, 100, 30) score:[model.grade integerValue] starWidth:16 intervel:3 needLabel:YES];
    [self addSubview:star];
}
@end
