//
//  YRDateCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRDateCell.h"

@implementation YRDateCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.timeStart];
        [self.contentView addSubview:self.timeEnd];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.173 green:0.550 blue:1.000 alpha:1.000];
    }
    return self;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.size.height/2-10, self.contentView.size.width, 20)];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}
-(UILabel *)timeStart{
    if (!_timeStart) {
        _timeStart = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.size.height/2-20, self.contentView.size.width, 20)];
        _timeStart.font = [UIFont systemFontOfSize:15];
        _timeStart.textAlignment = NSTextAlignmentCenter;
    }
    return _timeStart;
}
-(UILabel *)timeEnd{
    if (!_timeEnd) {
        _timeEnd = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.size.height/2, self.contentView.size.width, 20)];
        _timeEnd.font = [UIFont systemFontOfSize:15];
        _timeEnd.textAlignment = NSTextAlignmentCenter;
    }
    return _timeEnd;
}
@end
