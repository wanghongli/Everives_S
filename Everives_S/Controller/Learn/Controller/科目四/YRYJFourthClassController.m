//
//  YRYJFourthClassController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/18.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJFourthClassController.h"
#import "YRFirstHeadView.h"
#import "YRFirstMiddleView.h"
#import "YRFirstDownView.h"
#import "YRMyCollectionController.h"
#import "YRDriveLawController.h"
#import "YRLearnPracticeController.h"
#import "YRLearnExamController.h"//进入模拟考试
#import "YRSequencePracticeController.h"
#import "YRLearnOrderController.h"
#import "YRMyErrorController.h"
#import "YRMyAchievementController.h"
#import "YRMyPracticeController.h"
#import "YRLearnProfessionalController.h"
#import "YRFMDBObj.h"
#define kDistance 10
@interface YRYJFourthClassController ()<YRFirstHeadViewDelegate,YRFirstMiddleViewDelegate,YRFirstDownViewDelegate>

@property (nonatomic, strong) UIButton *examBtn;//进入模拟考试
@property (nonatomic, strong) YRFirstHeadView *headView;
@property (nonatomic, strong) YRFirstMiddleView *middleView;
@property (nonatomic, strong) YRFirstDownView *downView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation YRYJFourthClassController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kCOLOR(241, 241, 241);
    
    [self buildUI];
}
-(void)buildUI
{
    MyLog(@"%lf",kScreenHeight);//64 +50
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-50)];
    [self.view addSubview:_scrollView];
    //进入考试
    _examBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kDistance, kScreenWidth, kScreenWidth*0.435)];
    [_examBtn setBackgroundImage:[UIImage imageNamed:@"Learn_Home_Exam"] forState:UIControlStateNormal];
    [_scrollView addSubview:_examBtn];
    [_examBtn addTarget:self action:@selector(gotoExamClick:) forControlEvents:UIControlEventTouchUpInside];
    _examBtn.backgroundColor = [UIColor whiteColor];
    
    //顺序练习、随机练习、专题练习
    _headView = [[YRFirstHeadView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_examBtn.frame)+kDistance, kSizeOfScreen.width, kSizeOfScreen.width*0.25/0.78+30)];
    _headView.delegate = self;
    [_scrollView addSubview:_headView];
    
    if (kScreenHeight < 500) {//5、5s、4、4s
        
        _middleView = [[YRFirstMiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame)+kDistance, kSizeOfScreen.width, _headView.frame.size.height/2)];
        _middleView.delegate = self;
        [_scrollView addSubview:_middleView];
        
        _downView = [[YRFirstDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame)+kDistance, kSizeOfScreen.width, _headView.frame.size.height*2/3)];
        _downView.delegate = self;
        [_scrollView addSubview:_downView];
        
        if (CGRectGetMaxY(_downView.frame)>=self.scrollView.height) {
            _scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_downView.frame));
        }else{
            _scrollView.contentSize = CGSizeMake(kScreenWidth,self.scrollView.height);
        }
        return;
    }
    CGFloat heightLow;
    if (kScreenHeight == 568) {
        heightLow = kScreenHeight-64-50-CGRectGetMaxY(_headView.frame)-kDistance - 10;
    }else
        heightLow = kScreenHeight-64-50-CGRectGetMaxY(_headView.frame)-kDistance;
    
    //驾考法规、考试技巧
    _middleView = [[YRFirstMiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame)+kDistance, kSizeOfScreen.width, heightLow*3/7)];
    _middleView.delegate = self;
    [_scrollView addSubview:_middleView];
    
    //我的错题、我的收藏、练习统计、我的成绩
    _downView = [[YRFirstDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_middleView.frame)+kDistance, kSizeOfScreen.width, heightLow*4/7)];
    _downView.delegate = self;
    [_scrollView addSubview:_downView];
    
    if (CGRectGetMaxY(_downView.frame)>=self.scrollView.height) {
        _scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_downView.frame));
    }else{
        _scrollView.contentSize = CGSizeMake(kScreenWidth,self.scrollView.height);
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setMiddleViewMsg];
}
#pragma mark - 给顺序练习、随机练习和专题练习传值
-(void)setMiddleViewMsg
{
    NSArray *sxPractice = [YRFMDBObj getPracticeWithType:1 withSearchMsg:@"already = 1" withFMDB:[YRFMDBObj initFmdb]];
    NSArray *sjPractice = [YRFMDBObj getPracticeWithType:1 withSearchMsg:@"randomAlready = 1" withFMDB:[YRFMDBObj initFmdb]];
    NSArray *ztPractice = [YRFMDBObj getPracticeWithType:1 withSearchMsg:@"professionalAlready = 1" withFMDB:[YRFMDBObj initFmdb]];
    NSArray *allPractice = [YRFMDBObj getShunXuPracticeWithType:1 withFMDB:[YRFMDBObj initFmdb]];
    
    CGFloat sxPercent = (float)sxPractice.count/(float)allPractice.count;
    CGFloat sjPercent = (float)sjPractice.count/(float)allPractice.count;
    CGFloat ztPercent = (float)ztPractice.count/(float)allPractice.count;
    
    _headView.setPercentArray = @[[NSString stringWithFormat:@"%.2f",sxPercent],[NSString stringWithFormat:@"%.2f",sjPercent],[NSString stringWithFormat:@"%.2f",ztPercent]];
}
#pragma mark - 进入模拟考试
-(void)gotoExamClick:(UIButton *)sender
{
    MyLog(@"进入模拟考试");
    YRLearnExamController *examVC = [[YRLearnExamController alloc]init];
    examVC.objectFour = YES;
    [self.navigationController pushViewController:examVC animated:YES];
}
#pragma mark - 顺序、随机、专题等点击事件
-(void)firstHeadViewBtnClick:(NSInteger)btnTag
{
    YRLearnPracticeController *learnVC = [[YRLearnPracticeController alloc]init];
    if (btnTag == 0) {//顺序练习
        YRLearnOrderController *sequenceVC = [[YRLearnOrderController alloc]init];
        sequenceVC.objectFour = YES;
        [self.navigationController pushViewController:sequenceVC animated:YES];
        return;
    }else if (btnTag == 1){//随机练习
        learnVC.title = @"随机练习";
        learnVC.menuTag = 2;
        [self.navigationController pushViewController:learnVC animated:YES];
    }else{//专题练习
        YRLearnProfessionalController *learnVC = [[YRLearnProfessionalController alloc]init];
        learnVC.title = @"专题练习";
        learnVC.objFour = YES;
        [self.navigationController pushViewController:learnVC animated:YES];
    }
}
#pragma mark - 驾考法规、考试技巧等点击事件
-(void)firstMiddleViewBtnClick:(NSInteger)btnTag
{
    YRDriveLawController *lawVC = [[YRDriveLawController alloc]init];
    if (btnTag == 0) {//驾考法规
        lawVC.title = @"驾考法规";
    }else if (btnTag == 1){//考试技巧
        lawVC.title = @"考试技巧";
    }
    [self.navigationController pushViewController:lawVC animated:YES];
}
#pragma mark - 我的错题、我的收藏、练习统计、我的成绩等点击事件
-(void)firstDownBtnClick:(NSInteger)btnTag
{
    if (btnTag == 0) {//我的错题
        YRMyErrorController *errorVC = [[YRMyErrorController alloc]init];
        errorVC.objFour = YES;
        [self.navigationController pushViewController:errorVC animated:YES];
    }else if (btnTag == 1){//我的收藏
        YRMyCollectionController *collectVC = [[YRMyCollectionController alloc]init];
        collectVC.objFour = YES;
        [self.navigationController pushViewController:collectVC animated:YES];
    }else if (btnTag == 2){//练习统计
        YRMyPracticeController *practiceVC = [[YRMyPracticeController alloc]init];
        practiceVC.objFour = YES;
        [self.navigationController pushViewController:practiceVC animated:YES];
    }else{//我的成绩
        YRMyAchievementController *achieveVC = [[YRMyAchievementController alloc]init];
        achieveVC.objFour = YES;
        [self.navigationController pushViewController:achieveVC animated:YES];
    }
}@end
