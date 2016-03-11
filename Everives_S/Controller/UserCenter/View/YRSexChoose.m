//
//  YRSexChoose.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSexChoose.h"

#define kDistace 10
@interface YRSexChoose ()
@property (nonatomic, strong) UILabel *manLabel;
@property (nonatomic, strong) UILabel *womenLabel;
@property (nonatomic, strong) UIView *manView1;
@property (nonatomic, strong) UIView *manView2;
@property (nonatomic, strong) UIView *womenView1;
@property (nonatomic, strong) UIView *womenView2;
@property (nonatomic, strong) UIButton *manBtn;
@property (nonatomic, strong) UIButton *womenBtn;
@end
@implementation YRSexChoose

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{

    _manView1 = [[UIView alloc]init];
    [self addSubview:_manView1];
    
    _manView2 = [[UIView alloc]init];
    [self addSubview:_manView2];
    _manView2.hidden = YES;
    
    UILabel *manlabel = [[UILabel alloc]init];
    manlabel.text = @"绅士";
    manlabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:manlabel];
    _manLabel = manlabel;
    
    
    _womenView1 = [[UIView alloc]init];
    [self addSubview:_womenView1];
    
    _womenView2 = [[UIView alloc]init];
    [self addSubview:_womenView2];
    _womenView2.hidden = YES;
    
    _womenLabel = [[UILabel alloc]init];
    _womenLabel.text = @"淑女";
    _womenLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_womenLabel];
    
    
    _manBtn = [[UIButton alloc]init];
    [_manBtn addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
    _manBtn.tag = 20;
    [self addSubview:_manBtn];
    
    _womenBtn = [[UIButton alloc]init];
    [_womenBtn addTarget:self action:@selector(sexClick:) forControlEvents:UIControlEventTouchUpInside];
    _womenBtn.tag = 21;
    [self addSubview:_womenBtn];
}

-(void)sexClick:(UIButton *)sender
{
    if (sender.tag == 20) {//男
        _manView2.hidden = NO;
        _womenView2.hidden = YES;
    }else{//女
        _manView2.hidden = YES;
        _womenView2.hidden = NO;
    }
    [self.delegate sexChooseTag:(int)sender.tag-20];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _manView1.frame = CGRectMake(kDistace*2, self.height/4, self.height/2, self.height/2);
    _manView1.layer.masksToBounds = YES;
    _manView1.layer.cornerRadius = _manView1.height/2;
    _manView1.layer.borderColor = [UIColor blueColor].CGColor;
    _manView1.layer.borderWidth = 2;
    
    _manView2.frame = CGRectMake(0, 0, _manView1.height/2, _manView1.height/2);
    _manView2.center = _manView1.center;
    _manView2.layer.masksToBounds = YES;
    _manView2.layer.cornerRadius = _manView2.height/2;
    _manView2.backgroundColor = [UIColor blueColor];
    
    _manLabel.frame = CGRectMake(CGRectGetMaxX(_manView1.frame)+kDistace, _manView1.y, 40, _manView1.height);
    
    _manBtn.frame = CGRectMake(_manView1.x, 0, CGRectGetMaxX(_manLabel.frame)-CGRectGetMaxX(_manView1.frame), self.height);
    
    _womenView1.frame = CGRectMake(self.width/2, self.height/4, self.height/2, self.height/2);
    _womenView1.layer.masksToBounds = YES;
    _womenView1.layer.cornerRadius = _manView1.height/2;
    _womenView1.layer.borderColor = [UIColor blueColor].CGColor;
    _womenView1.layer.borderWidth = 2;
    
    _womenView2.frame = CGRectMake(0, 0, _manView1.height/2, _manView1.height/2);
    _womenView2.center = _womenView1.center;
    _womenView2.layer.masksToBounds = YES;
    _womenView2.layer.cornerRadius = _manView2.height/2;
    _womenView2.backgroundColor = [UIColor blueColor];
    
    _womenLabel.frame = CGRectMake(CGRectGetMaxX(_womenView1.frame)+kDistace, _womenView1.y, 40, _womenView1.height);
    
    _womenBtn.frame = CGRectMake(_womenView1.x, 0, CGRectGetMaxX(_womenLabel.frame)-CGRectGetMaxX(_womenView1.frame), self.height);
}
@end
