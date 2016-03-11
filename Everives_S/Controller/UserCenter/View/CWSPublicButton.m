//
//  CWSPublicButton.m
//  测试demo
//
//  Created by 李散 on 15/9/23.
//  Copyright (c) 2015年 cheweishi. All rights reserved.
//

#import "CWSPublicButton.h"

@implementation CWSPublicButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:86/255.0 blue:85/255.0 alpha:1];
    }
    return self;
}

@end
