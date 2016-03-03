//
//  CWSReadPolicyView.m
//  测试demo
//
//  Created by 李散 on 15/9/24.
//  Copyright © 2015年 cheweishi. All rights reserved.
//

#import "CWSReadPolicyView.h"
//#import "UIView+Frame.h"
@interface CWSReadPolicyView ()
@property (nonatomic, strong) UIButton *leftBtn;//左侧按钮点击
@property (nonatomic, strong) UIButton *rightBtn;//右侧按钮点击
@end

@implementation CWSReadPolicyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
    }
    return self;
}
-(UIButton *)leftBtn
{
    if (_leftBtn == nil) {
        UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString* titleString = @" 我已经阅读并";
        UIImage*image = [UIImage imageNamed:@"home_onclick1"];
        UIImage *selectImg = [UIImage imageNamed:@"home_click2"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:titleString forState:UIControlStateNormal];
        [btn setImage:selectImg forState:UIControlStateSelected];
        btn.selected = YES;
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(readClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftBtn = btn;
        [self addSubview:_leftBtn];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn
{
    if (_rightBtn == nil) {
        UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString* titleString = @"同意使用条款和隐私政策";
        [btn setTitle:titleString forState:UIControlStateNormal];
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(policyVC) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn = btn;
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    NSString* titleString = @" 我已经阅读并";
    CGSize stringOfSize=[titleString boundingRectWithSize:CGSizeMake(275, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
    _leftBtn.imageView.x = 0;
    CGFloat width = stringOfSize.width+25;
    self.leftBtn.frame = CGRectMake(0, 0, width, 20);
    NSString* titleString1 = @"同意使用条款和隐私政策";
    CGSize stringOfSize1=[titleString1 boundingRectWithSize:CGSizeMake(275, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size;
    self.rightBtn.frame = CGRectMake(_leftBtn.x+_leftBtn.width, 0, stringOfSize1.width, 20);
}
- (void)readClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    [self.delegate readPolicyViewTochDown:sender.selected];
}
- (void)policyVC
{
    [self.delegate readPolicyViewTurnToPolicyVC];
}


@end
