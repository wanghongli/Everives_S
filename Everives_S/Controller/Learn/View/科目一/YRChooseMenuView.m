//
//  YRChooseMenuView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/5.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRChooseMenuView.h"
@interface YRChooseMenuView ()
@property (nonatomic, weak) UILabel *menuLabel;
@end
@implementation YRChooseMenuView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    
    UILabel *menulabel = [[UILabel alloc]init];
    menulabel.font = kFontOfSize(14);
    menulabel.textColor = [UIColor blackColor];
    menulabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:menulabel];
    _menuLabel = menulabel;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _menuLabel.frame = CGRectMake(0, 0, self.width, self.height);
    _menuLabel.layer.masksToBounds = YES;
    _menuLabel.layer.cornerRadius = _menuLabel.height/2;
    _menuLabel.layer.borderWidth = 1;
}
-(void)setMenuString:(NSString *)menuString
{
    _menuString = menuString;
    _menuLabel.text = menuString;
}
-(void)setShowImgBool:(BOOL)showImgBool
{
    _showImgBool = showImgBool;
    _menuLabel.hidden = YES;
    NSString *imgString = showImgBool?@"right_img":@"error_img";
    self.image = [UIImage imageNamed:imgString];
}

/**
 *  0表示默认状态（单选或者判断题）  1表示选中状态（多项选择）  2表示多项选择没有选的正确答案状态（多项选择题）
 */
-(void)setSelectState:(NSInteger)selectState
{
    _selectState = selectState;
    _menuLabel.hidden = NO;
    _menuLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.image = nil;
    if (selectState == 0) {//0表示默认状态（单选或者判断题）
        _menuLabel.backgroundColor = [UIColor whiteColor];
        _menuLabel.textColor = [UIColor blackColor];
    }else if(selectState == 1){//1表示选中状态（多项选择）
        _menuLabel.backgroundColor = [UIColor lightGrayColor];
        _menuLabel.textColor = [UIColor whiteColor];
    }else{//2表示多项选择没有选的正确答案状态（多项选择题）
        _menuLabel.textColor = [UIColor whiteColor];
        _menuLabel.backgroundColor = kCOLOR(24, 180, 237);
        _menuLabel.layer.borderColor = kCOLOR(24, 180, 237).CGColor;
    }
}
@end
