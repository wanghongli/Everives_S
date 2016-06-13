//
//  YRActivityTableViewCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRActivityTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation YRActivityTableViewCell

- (void)awakeFromNib {
    _titleL.textColor = kYRBlackTextColor;
    _contentL.textColor = kYRLightTextColor;
    _contentL.numberOfLines = 0;
    _contentL.lineBreakMode = NSLineBreakByWordWrapping;
    _dateL.textColor = kYRBlackTextColor;
    [self.contentView addSubview:self.shadowview];
}

-(void)setModel:(YRActivityModel *)model{
//    [_picView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
//    _titleL.text = model.title;
//    _contentL.text = model.intro;
//    _dateL.text = model.begintime;
    _picView.image = [UIImage imageNamed:@"backImg"];
    _titleL.text = @"中秋节充值有礼!";
    _dateL.text = @"2016.06.18";
    _contentL.text = @"马上就到中秋佳节了，蚁众驾为驾友送上最诚挚的中秋祝福。中秋节充值，即可获得双倍学车币。马上就到中秋佳节了，蚁众驾为驾友送上最诚挚的中秋祝福。中秋节充值，即可获得双倍学车币。";
}
-(UIView *)shadowview{
    if (!_shadowview) {
        _shadowview = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, kScreenWidth+20, 150)];
        _shadowview.layer.shadowOffset = CGSizeMake(1, 0);
        _shadowview.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
        _shadowview.layer.shadowRadius = 1;
        _shadowview.layer.shadowOpacity = 0.5;
        CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-10, 148, kScreenWidth+20, 1)].CGPath;
        _shadowview.layer.shadowPath = shadowPath;
    }
    return _shadowview;
}
@end
