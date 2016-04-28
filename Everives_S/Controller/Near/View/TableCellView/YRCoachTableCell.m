//
//  YRCoachTableCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCoachTableCell.h"
#import "YRCoachModel.h"
#import <UIImageView+WebCache.h>
#import "YRStarsView.h"
@implementation YRCoachTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(YRCoachModel *)model{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    _name.text = model.name;
    _teachAge.text = [NSString stringWithFormat:@"教龄 %@年",model.year];
    _stuNum.text = [NSString stringWithFormat:@"学员 %@个",model.student];
    _distance.text = [NSString stringWithFormat:@"%.2f%@",([model.distance integerValue]/1000.0),@"km"];
    _distance.textColor = kTextlightGrayColor;
    _course.text = [model.kind isEqualToString:@"0"]?@"科目二":@"科目三";
    YRStarsView *star = [[YRStarsView alloc] initWithFrame:CGRectMake(_name.frame.origin.x, 26, 100, 30) score:[model.grade integerValue] starWidth:16 intervel:3 needLabel:YES];
    [self addSubview:star];
}
@end
