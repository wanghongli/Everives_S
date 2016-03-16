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
        self.backgroundColor = [UIColor whiteColor];
        // 设置左边的view
        // initWithImage:默认UIImageView的尺寸跟图片一样
        
        // 一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
        self.leftViewMode = UITextFieldViewModeAlways;
        self.backgroundColor = self.superview.backgroundColor;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.borderColor = [UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1].CGColor;
        self.layer.borderWidth = 1;
        
    }
    return self;
}
-(void)setLeftImage:(UIImage *)leftImage
{
    _leftImage = leftImage;
    UIImageView *imageV = [[UIImageView alloc] initWithImage:leftImage];//searchbar_textfield_search_icon
    imageV.width += 20;
    imageV.contentMode = UIViewContentModeCenter;
    self.leftView = imageV;
}

-(void)setLeftString:(NSString *)leftString
{
    _leftString = leftString;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = leftString;
    label.font = [UIFont systemFontOfSize:14];
    self.leftView = label;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self resignFirstResponder];
    return YES;
}
@end
