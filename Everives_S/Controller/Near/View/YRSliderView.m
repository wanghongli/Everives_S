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
        self.backgroundColor = [UIColor colorWithWhite:0.923 alpha:1.000];
        [self addSubview:self.minLab];
        [self addSubview:self.maxLab];
        [self addSubview:self.slider];
    }
    return self;
}
-(UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(80, 32,self.frame.size.width-160, 20)];
        _slider.minimumValue = 0;
        _slider.maximumValue = 100;
        _slider.value = 0;
        [_slider setThumbImage:[UIImage imageNamed:@"Drawer_Navigation_learn"] forState:UIControlStateNormal];
    }
    return _slider;
}

-(UILabel *)minLab{
    if (!_minLab) {
        _minLab = [[UILabel alloc] initWithFrame:CGRectMake(65, 8, 80, 20)];
        _minLab.text = @"科二教练";
        _minLab.font = kFontOfLetterSmall;
    }
    return _minLab;
}
-(UILabel *)maxLab{
    if (!_maxLab) {
        _maxLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-105, 8, 80, 20)];
        _maxLab.text = @"科三教练";
        _maxLab.font = kFontOfLetterSmall;
    }
    return _maxLab;
}
@end
