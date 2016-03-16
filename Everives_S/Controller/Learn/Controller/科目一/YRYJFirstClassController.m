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
#import "YRMyCollectionController.h"
#import "YRDriveLawController.h"
#import "YRLearnPracticeController.h"
#define kDistance 10
@interface YRYJFirstClassController ()<YRFirstHeadViewDelegate,YRFirstMiddleViewDelegate,YRFirstDownViewDelegate>

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
    [_examBtn addTarget:self action:@selector(gotoExamClick:) forControlEvents:UIControlEventTouchUpInside];
    _examBtn.backgroundColor = [UIColor whiteColor];
    
    _headView = [[YRFirstHeadView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_examBtn.frame)+kDistance, kSizeOfScreen.width, kSizeOfScreen.width*0.25/0.78+30)];
    _headView.delegate = self;
    [self.view addSubview:_headView];
    
    _middleView = [[YRFirstMiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame)+kDistance, kSizeOfScreen.width, _headView.frame.size.height/2)];
    _middleView.delegate = self;
    [self.view addSubview:_middleView];
    
    _downView = [[YRFirstDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame)+kDistance, kSizeOfScreen.width, _headView.frame.size.height*2/3)];
    _downView.delegate = self;
    [self.view addSubview:_downView];
    
}
#pragma mark - 进入模拟考试
-(void)gotoExamClick:(UIButton *)sender
{
    MyLog(@"进入模拟考试");
}
#pragma mark - 顺序、随机、专题等点击事件
-(void)firstHeadViewBtnClick:(NSInteger)btnTag
{
    YRLearnPracticeController *learnVC = [[YRLearnPracticeController alloc]init];
    if (btnTag == 0) {//顺序练习
        learnVC.title = @"顺序练习";
    }else if (btnTag == 1){//随机练习
        learnVC.title = @"随机练习";
    }else{//专题练习
        learnVC.title = @"专题练习";
    }
    [self.navigationController pushViewController:learnVC animated:YES];

}
#pragma mark - 驾考法规、考试技巧等点击事件
-(void)firstMiddleViewBtnClick:(NSInteger)btnTag
{
    if (btnTag == 0) {//驾考法规
        YRDriveLawController *lawVC = [[YRDriveLawController alloc]init];
        [self.navigationController pushViewController:lawVC animated:YES];
    }else if (btnTag == 1){//考试技巧
        
    }
}
#pragma mark - 我的错题、我的收藏、练习统计、我的成绩等点击事件
-(void)firstDownBtnClick:(NSInteger)btnTag
{
    if (btnTag == 0) {//我的错题
        
    }else if (btnTag == 1){//我的收藏
        YRMyCollectionController *collectVC = [[YRMyCollectionController alloc]init];
        [self.navigationController pushViewController:collectVC animated:YES];
    }else if (btnTag == 2){//练习统计
        
    }else{//我的成绩
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
