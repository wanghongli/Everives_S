//
//  UIButton+titleFrame.m
//  测试demo
//
//  Created by 李散 on 15/9/23.
//  Copyright (c) 2015年 cheweishi. All rights reserved.
//

#import "UIButton+titleFrame.h"
@implementation UIButton (titleFrame)
-(void)setFrameWithTitle:(NSString *)title forState:(UIControlState)state
{
    CGSize stringOfSize=[title boundingRectWithSize:CGSizeMake(275, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
    
    CGRect frame = self.frame;
    if (![title isEqualToString:@"忘记密码?"]) {
        frame.origin.x = self.frame.origin.x- stringOfSize.width;
    }
    frame.size.width = stringOfSize.width;
    self.frame = frame;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor colorWithRed:250/255.0 green:86/255.0 blue:85/255.0 alpha:1] forState:UIControlStateNormal];
    [self setTitle:title forState:state];
}
@end
