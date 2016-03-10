//
//  YRYJFirstClassController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/18.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJFirstClassController.h"
#import "YRFirstHeadView.h"
#import "YRFirstMiddleView.h"
#import "YRFirstDownView.h"
#define kDistance 10
@interface YRYJFirstClassController ()

@property (nonatomic, strong) UIButton *examBtn;//进入模拟考试
@property (nonatomic, strong) YRFirstHeadView *headView;
@property (nonatomic, strong) YRFirstMiddleView *middleView;
@property (nonatomic, strong) YRFirstDownView *downView;
@end

@implementation YRYJFirstClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCOLOR(241, 241, 241);
    
    [self buildUI];
}
-(void)buildUI
{
    _examBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kDistance, kScreenWidth, 44)];
    [_examBtn setTitle:@" 进入模拟考试" forState:UIControlStateNormal];
    [_examBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_examBtn setImage:[UIImage imageNamed:@"home_click2"] forState:UIControlStateNormal];
    [self.view addSubview:_examBtn];
    _examBtn.backgroundColor = [UIColor whiteColor];
    
    _headView = [[YRFirstHeadView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_examBtn.frame)+kDistance, kSizeOfScreen.width, kSizeOfScreen.width*0.25/0.78+30)];
    [self.view addSubview:_headView];
    
    _middleView = [[YRFirstMiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame)+kDistance, kSizeOfScreen.width, _headView.frame.size.height/2)];
    [self.view addSubview:_middleView];
    
    _downView = [[YRFirstDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame)+kDistance, kSizeOfScreen.width, _headView.frame.size.height*2/3)];
    [self.view addSubview:_downView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
