//
//  YRLeftImgBtn.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLeftImgBtn.h"
#define kDistance 5
@implementation YRLeftImgBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat wh = frame.size.height-2*kDistance;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = wh/2;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat wh = contentRect.size.height-2*kDistance;
    CGSize titleSize = [@"驾考法规"  sizeWithFont:kFontOfSize(14) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat kdistace = (contentRect.size.width - wh - titleSize.width)/3;
    return CGRectMake(kdistace*2+wh, 0, titleSize.width, contentRect.size.height);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat wh = contentRect.size.height-2*kDistance;
    CGSize titleSize = [@"驾考法规"  sizeWithFont:kFontOfSize(14) maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    CGFloat kdistace = (contentRect.size.width - wh - titleSize.width)/3;
    return CGRectMake(kdistace, kDistance, wh, wh);
}
@end
