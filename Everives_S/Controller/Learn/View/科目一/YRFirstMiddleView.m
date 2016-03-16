//
//  YRFirstMiddleView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFirstMiddleView.h"
#import "YRLeftImgBtn.h"

#define kDistance 5
@interface YRFirstMiddleView ()
{
    NSArray *array;
}
@end
@implementation YRFirstMiddleView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        array = @[@"驾考法规",@"考试技巧"];
        self.backgroundColor = kCOLOR(241, 241, 241);
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{
    for (int i = 0; i<2; i++) {
        CGFloat w = (kSizeOfScreen.width-kDistance)/2;
        CGFloat x = i*kDistance+i*w;
        CGFloat y = 0;
        CGFloat h = self.frame.size.height;
        YRLeftImgBtn *leftBtn = [[YRLeftImgBtn alloc]initWithFrame:CGRectMake(x, y, w, h)];
        [leftBtn setTitle:array[i] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:kPLACEHHOLD_IMG] forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor colorWithRed:145/255.0 green:146/255.0 blue:147/255.0 alpha:1] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(btnCLick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.tag = i;
        [self addSubview:leftBtn];
    }
}

-(void)btnCLick:(YRLeftImgBtn *)sender
{
    [self.delegate firstMiddleViewBtnClick:sender.tag];
}

@end
