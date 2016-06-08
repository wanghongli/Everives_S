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
#import <UIImageView+WebCache.h>
#import "YRPictureModel.h"
@implementation YRSchoolTableCell

- (void)awakeFromNib {
    _intro.frame = CGRectMake(113, 93, kScreenWidth-129, 12);
    _addr.frame = CGRectMake(113, 67, kScreenWidth-129, 12);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(YRSchoolModel *)model{
    [_image sd_setImageWithURL:[NSURL URLWithString:((YRPictureModel*)(model.pics[0])).url] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    _name.text = model.name;
    _addr.text = model.address;
    _intro.text = model.intro;
    _distance.text = [NSString stringWithFormat:@"距离%.1f%@",([model.distance integerValue]/1000.0),@"km"];
    YRStarsView *star = [[YRStarsView alloc] initWithFrame:CGRectMake(_name.frame.origin.x-3, 34, 100, 30) score:[model.grade integerValue] starWidth:23 intervel:3 needLabel:YES];
    [self addSubview:star];
}
@end
