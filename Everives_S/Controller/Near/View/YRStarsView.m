//
//  YRStarsView.m
//  Everives_S
//
//  Created by darkclouds on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRStarsView.h"
@implementation YRStarsView

-(instancetype)initWithFrame:(CGRect)frame score:(NSInteger)score starWidth:(CGFloat)starWidth intervel:(CGFloat)intervel needLabel:(BOOL)needL{
    if (self = [super initWithFrame:frame]) {
        for (NSInteger i = 0; i<5; i++) {
            UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(starWidth*i+(i!=0?intervel:0), (frame.size.height-starWidth)/2, starWidth, starWidth)];
            if (i<score) {
                star.image = [UIImage imageNamed:@"Neig_Coach_StaOrg"];
            }else{
                star.image = [UIImage imageNamed:@"Neig_Coach_StaGre"];
            }
            [self addSubview:star];
        }
    }
    if (needL) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((starWidth+intervel)*5, (frame.size.height-starWidth)/2, 2*starWidth, starWidth)];
        label.font = [UIFont systemFontOfSize:13];
        label.text = [NSString stringWithFormat:@"%li.0",score];
        [self addSubview:label];
    }
    return self;
}

@end
