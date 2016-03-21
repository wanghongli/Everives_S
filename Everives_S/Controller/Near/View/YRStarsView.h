//
//  YRStarsView.h
//  Everives_S
//
//  Created by darkclouds on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRStarsView : UIView
@property(nonatomic,strong) UILabel *label;
-(instancetype)initWithFrame:(CGRect)frame score:(NSInteger) score starWidth:(CGFloat)starWidth intervel:(CGFloat)intervel needLabel:(BOOL) needL;
-(void)setScore:(NSInteger)score;
@end