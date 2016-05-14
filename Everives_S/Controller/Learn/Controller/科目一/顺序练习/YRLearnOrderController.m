//
//  YRLearnOrderController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnOrderController.h"
#import "YRLearnPracticeController.h"

#import "SDProgressView.h"
#import "SDDemoItemView.h"
#import "YRFMDBObj.h"
@interface YRLearnOrderController ()
@property (nonatomic ,strong) SDDemoItemView *itemView;
@property (nonatomic, strong) UILabel *currentProgress;
@end

@implementation YRLearnOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"顺序练习";
    
    [self buildUI];
}
-(void)buildUI
{
    self.baseView.frame = CGRectMake(0, 0, kScreenWidth, self.baseView.height);
    [self.view addSubview:self.baseView];
    
    self.goOnBtn.layer.masksToBounds = YES;
    self.goOnBtn.layer.cornerRadius = self.goOnBtn.height/2;
    
    self.replyBtn.layer.masksToBounds = YES;
    self.replyBtn.layer.cornerRadius = self.replyBtn.height/2;
    self.replyBtn.layer.borderWidth = 1;
    self.replyBtn.layer.borderColor = kCOLOR(51, 51, 51).CGColor;
    
    self.startAnswerQues.layer.masksToBounds = YES;
    self.startAnswerQues.layer.cornerRadius = self.replyBtn.height/2;
    self.startAnswerQues.layer.borderWidth = 1;
    self.startAnswerQues.layer.borderColor = kCOLOR(51, 51, 51).CGColor;
    
    self.itemView = [SDDemoItemView demoItemViewWithClass:[SDLoopProgressView class]];
    self.itemView.frame = CGRectMake(0, 0, self.headView.height*0.6, self.headView.height*0.6);
    self.itemView.userInteractionEnabled = NO;
    self.itemView.center = CGPointMake(kScreenWidth/2, self.headView.height/2+20);
    [self.headView addSubview:self.itemView];
    
    self.currentProgress = [[UILabel alloc]initWithFrame:CGRectMake(0, self.itemView.y-20, kScreenWidth, 20)];
    self.currentProgress.textAlignment = NSTextAlignmentCenter;
    self.currentProgress.text = @"当前进度";
    self.currentProgress.font = kFontOfLetterMedium;
    [self.headView addSubview:self.currentProgress];
    
   
    // 模拟下载进度
//    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressSimulation) userInfo:self repeats:YES];
//    [self progressSimulation];
    
    if ([YRFMDBObj getCurrentQuestionIDWithType:self.objectFour]) {
        self.startAnswerQues.hidden = YES;
        self.goOnBtn.hidden = NO;
        self.replyBtn.hidden = NO;
    }else{
        self.startAnswerQues.hidden = NO;
        self.goOnBtn.hidden = YES;
        self.replyBtn.hidden = YES;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSArray *array = [YRFMDBObj getErrorAlreadyAndTotalQuestionWithType:self.objectFour already:0];
    self.totalNum.text = array[0];
    self.errorNum.text = array[1];
    self.completeNum.text = array[2];
    CGFloat percent = [array[2] floatValue]/[array[0] floatValue];
    self.itemView.progressView.progress = percent;
}
- (void)progressSimulation
{
    static CGFloat progress = 0;
    
    if (progress < 0.8) {
        progress += 0.01;
        self.itemView.progressView.progress = progress;
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    YRLearnPracticeController *practiceVC = [[YRLearnPracticeController alloc]init];
    practiceVC.title = @"顺序练习";
    if (sender.tag == 20) {//继续答题
        practiceVC.currentID = [YRFMDBObj getCurrentQuestionIDWithType:self.objectFour];
    }else{//重新答题
        [YRFMDBObj saveMsgWithMsg:0 withType:self.objectFour];
        practiceVC.currentID = 0;
    }
    practiceVC.objectFour = self.objectFour;
    practiceVC.menuTag = 1;
    [self.navigationController pushViewController:practiceVC animated:YES];
}
@end
