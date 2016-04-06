//
//  YRUpImgBtn.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUpImgBtn.h"
#import "UIView+SDAutoLayout.h"

@implementation YRUpImgBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = frame.size.width/-3;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize titleSize = [@"我的错题" sizeWithFont:kFontOfSize(12) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat kdistace = (contentRect.size.height - titleSize.height-contentRect.size.width + 6)/3;
    return CGRectMake(3, kdistace, contentRect.size.width-6, contentRect.size.width-6);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize titleSize = [@"我的错题" sizeWithFont:kFontOfSize(12) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];

    CGFloat kdistace = (contentRect.size.height - titleSize.height -contentRect.size.width+6)/3;
    return CGRectMake(0, 2*kdistace+contentRect.size.width-6, contentRect.size.width, titleSize.height);
}
@end
