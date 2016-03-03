//
//  CWSLoginTextField.m
//  text_demo
//
//  Created by 李散 on 15/9/23.
//  Copyright (c) 2015年 cheweishi. All rights reserved.
//

#import "CWSLoginTextField.h"
@implementation CWSLoginTextField
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
//        self.background = [UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        self.backgroundColor = [UIColor whiteColor];
        // 设置左边的view
        // initWithImage:默认UIImageView的尺寸跟图片一样
        
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //添加右侧删除按钮
        UIImage*image = [UIImage imageNamed:@"login_shanchu_right"];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setImage:image forState:UIControlStateNormal];
        self.delegate = self;
        self.rightView = btn;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        [btn addTarget:self action:@selector(clearSelfMsg:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView*downView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
        downView.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
        [self addSubview:downView];
        
        self.backgroundColor = self.superview.backgroundColor;
    }
    return self;
}
-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    UIImageView *imageV = [[UIImageView alloc] initWithImage:leftImage];//searchbar_textfield_search_icon
    imageV.width += 15;
    imageV.contentMode = UIViewContentModeCenter;
    self.leftView = imageV;
}
- (void)clearSelfMsg:(UIButton*)sender
{
    self.text = @"";
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
}
@end
