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
        
        self.imageView.sd_layout
        .leftSpaceToView(self,0)
        .topSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .widthIs(frame.size.width)
        .heightIs(frame.size.width);
        
        self.titleLabel.sd_layout
        .leftSpaceToView(self,0)
        .rightSpaceToView(self,0)
        .bottomSpaceToView(self,0)
        .widthIs(frame.size.width);
        self.imageView.layer.masksToBounds = YES;
        self.imageView.layer.cornerRadius = frame.size.width/2;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height-20, contentRect.size.width, 20);
}
@end
