//
//  YRStarsView.m
//  Everives_S
//
//  Created by darkclouds on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRStarsView.h"
@interface YRStarsView(){
    CGFloat _starWidth;
    CGFloat _intervel;
}
@end
@implementation YRStarsView

-(instancetype)initWithFrame:(CGRect)frame score:(NSInteger)score starWidth:(CGFloat)starWidth intervel:(CGFloat)intervel needLabel:(BOOL)needL{
    if (self = [super initWithFrame:frame]) {
        _starWidth = starWidth;
        _intervel = intervel;
        for (NSInteger i = 0; i<5; i++) {
            UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(starWidth*i+(i!=0?intervel:0), (frame.size.height-starWidth)/2, starWidth, starWidth)];
            if (i<score) {
                star.image = [UIImage imageNamed:@"bigStarOrg"];
            }else{
                star.image = [UIImage imageNamed:@"SmallStarGray"];
            }
            [self addSubview:star];
        }
    }
    if (needL) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake((starWidth+intervel)*5, (frame.size.height-starWidth)/2, 2*starWidth, starWidth)];
        _label.font = [UIFont systemFontOfSize:13];
        _label.text = [NSString stringWithFormat:@"%li.0",score];
        [self addSubview:_label];
    }
    return self;
}

-(void)setScore:(NSInteger)score{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIImageView class]]){
            [obj removeFromSuperview];
        }
    }];
    for (NSInteger i = 0; i<5; i++) {
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(_starWidth*i+(i!=0?_intervel:0), (self.frame.size.height-_starWidth)/2, _starWidth, _starWidth)];
        if (i<score) {
            star.image = [UIImage imageNamed:@"bigStarOrg"];
        }else{
            star.image = [UIImage imageNamed:@"SmallStarGray"];
        }
        [self addSubview:star];
    }
}
@end
