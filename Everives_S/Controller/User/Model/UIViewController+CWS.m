//
//  UIViewController+CWS.m
//  测试demo
//
//  Created by 李散 on 15/9/23.
//  Copyright (c) 2015年 cheweishi. All rights reserved.
//

#import "UIViewController+CWS.h"

@implementation UIViewController (CWS)

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
