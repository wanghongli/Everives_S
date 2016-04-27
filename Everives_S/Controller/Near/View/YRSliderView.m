//
//  YRSliderView.m
//  Everives_S
//
//  Created by darkclouds on 16/4/14.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSliderView.h"

@implementation YRSliderView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = kCOLOR(249, 249, 249);
        [self addSubview:self.minLab];
        [self addSubview:self.maxLab];
        [self addSubview:self.slider];
    }
    return self;
}
-(YRSlider *)slider{
    if (!_slider) {
        _slider = [[YRSlider alloc] initWithFrame:CGRectMake(80, 10,self.frame.size.width-160, 80)];
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
        _slider.value = 0;
        _slider.minimumTrackTintColor = kCOLOR(237, 237, 237);
        _slider.maximumTrackTintColor = kCOLOR(237, 237, 237);
        [_slider setThumbImage:[UIImage imageNamed:@"Near_CoachFillter"] forState:UIControlStateNormal];
    }
    return _slider;
}

-(UILabel *)minLab{
    if (!_minLab) {
        _minLab = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 80, 20)];
        _minLab.text = @"科二教练";
        _minLab.font = [UIFont systemFontOfSize:10];
    }
    return _minLab;
}
-(UILabel *)maxLab{
    if (!_maxLab) {
        _maxLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-105, 5, 80, 20)];
        _maxLab.text = @"科三教练";
        _maxLab.font = [UIFont systemFontOfSize:10];
    }
    return _maxLab;
}
@end
