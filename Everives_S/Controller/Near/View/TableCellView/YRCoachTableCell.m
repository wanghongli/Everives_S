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
    if (([model.distance integerValue]/1000.0)>10000) {
        _distance.text = @"距离未知";
    }else{
        _distance.text = [NSString stringWithFormat:@"距离%.1f%@",([model.distance integerValue]/1000.0),@"km"];
    }
    _distance.textColor = kTextlightGrayColor;
    if ([model.kind isEqualToString:@"0"]) {
        _course.text = @" 科目二 ";
        _course.textColor = kCOLOR(185, 97, 167);
        _course.layer.borderColor = kCOLOR(185, 97, 167).CGColor;
    }else if([model.kind isEqualToString:@"1"]){
        _course.text = @" 科目三 ";
        _course.textColor = kCOLOR(60, 90, 167);
        _course.layer.borderColor = kCOLOR(60, 90, 167).CGColor;
    }else{
        _course.text = @"陪练陪驾";
        _course.textColor = kCOLOR(60, 90, 150);
        _course.layer.borderColor = kCOLOR(60, 90, 150).CGColor;
    }
    _course.layer.cornerRadius = 10.5;
    _course.layer.masksToBounds = YES;
    _course.layer.borderColor = kCOLOR(180, 80, 163).CGColor;
    _course.layer.borderWidth = 1;
    YRStarsView *star = [[YRStarsView alloc] initWithFrame:CGRectMake(_name.frame.origin.x, 36, 100, 30) score:[model.grade integerValue] starWidth:16 intervel:3 needLabel:YES];
    [self addSubview:star];
}
@end
