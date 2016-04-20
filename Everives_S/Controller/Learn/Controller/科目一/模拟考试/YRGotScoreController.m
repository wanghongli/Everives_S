//
//  YRGotScoreController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/25.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRGotScoreController.h"
#import "YRExamScorePercentView.h"
#import "YRMyErrorController.h"
#import "YRPublicMethod.h"
#define kImgW 120
#define kImgH 160
#define kToTopDestace 20
@interface YRGotScoreController ()

@property (nonatomic, strong) UIImageView *scoreBackImg;
@property (nonatomic, strong) UILabel *yourScore;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *descriLabel;
@property (nonatomic, strong) UIButton *errorBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) YRExamScorePercentView *scorePercentView;
@end

@implementation YRGotScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"得分";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildUI];
    [self.errorBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
    
    [self saveAchievement];
}
#pragma mark - 保存成绩
-(void)saveAchievement
{
    if (self.objFour) {//科目四
        
    }else{//科目一
        
    }
}
-(void)buildUI
{
    self.scoreBackImg.image = [UIImage imageNamed:@"Learn_Grade-1_Score"];
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld",self.scroe];
    if (self.scroe>=90) {
        self.descriLabel.text = @"恭喜您达到合格标准!";
    }else
        self.descriLabel.text = @"不要灰心，继续努力!";
    self.scorePercentView.headString = @"您的排名为";
    self.scorePercentView.scoreString = @"88";
}
-(void)backClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 11) {//错题
        YRMyErrorController *errorVC = [[YRMyErrorController alloc]init];
        [self.navigationController pushViewController:errorVC animated:YES];
    }else{//分享
    
    }
}
-(UILabel *)yourScore
{
    if (!_yourScore) {
        _yourScore = [[UILabel alloc]initWithFrame:CGRectMake(0, kToTopDestace+64, kScreenWidth, kToTopDestace)];
        _yourScore.text = @"您的得分";
        _yourScore.textAlignment = NSTextAlignmentCenter;
        _yourScore.font = kFontOfLetterBig;
        _yourScore.textColor = kCOLOR(51, 51, 51);
        [self.view addSubview:_yourScore];
    }
    
    return _yourScore;
}
-(UIImageView *)scoreBackImg
{
    if (!_scoreBackImg) {
        _scoreBackImg = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-kImgW/2, CGRectGetMaxY(self.yourScore.frame)+kToTopDestace/2, kImgW, kImgH)];
        [self.view addSubview:_scoreBackImg];
    }
    return _scoreBackImg;
}
-(UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _scoreBackImg.width, _scoreBackImg.width)];
        _scoreLabel.font = kFontOfSize(30);
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        [_scoreBackImg addSubview:_scoreLabel];
        
    }
    return _scoreLabel;
}
-(UILabel *)descriLabel
{
    if (!_descriLabel) {
        _descriLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scoreBackImg.frame)+kToTopDestace, kScreenWidth, 20)];
        _descriLabel.font = kFontOfLetterBig;
        _descriLabel.textAlignment = NSTextAlignmentCenter;
        _descriLabel.textColor = [UIColor blackColor];
        [self.view addSubview:_descriLabel];
    }
    return _descriLabel;
}
-(YRExamScorePercentView *)scorePercentView
{
    if (!_scorePercentView) {
        
        _scorePercentView = [[YRExamScorePercentView alloc]initWithFrame:CGRectMake(kScreenWidth/2-[YRExamScorePercentView getExamScorePercentViewHeight:@"99" withHeadString:@"您的排名为"]/2, CGRectGetMaxY(self.descriLabel.frame)+kToTopDestace/2, [YRExamScorePercentView getExamScorePercentViewHeight:@"99" withHeadString:@"您的排名为"], [@"99" sizeWithFont:kFontOfSize(30) maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height)];
        [self.view addSubview:_scorePercentView];
        
    }
    return _scorePercentView;
}

-(UIButton *)errorBtn
{
    if (!_errorBtn) {
        _errorBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*0.15, CGRectGetMaxY(_scorePercentView.frame)+kToTopDestace, (kScreenWidth*0.7-kToTopDestace)/2, 40)];
        [_errorBtn setTitle:@"查看错题" forState:UIControlStateNormal];
        [_errorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _errorBtn.backgroundColor = kCOLOR(71, 71, 71);
        _errorBtn.titleLabel.font = kFontOfLetterBig;
        _errorBtn.layer.masksToBounds = YES;
        _errorBtn.tag = 11;
        _errorBtn.layer.cornerRadius = _errorBtn.height/2;
        [self.view addSubview:_errorBtn];
    }
    return _errorBtn;
}
-(UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_errorBtn.frame)+kToTopDestace, _errorBtn.y, (kScreenWidth*0.7-kToTopDestace)/2, _errorBtn.height)];
        [_shareBtn setTitle:@"分享成绩" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:kCOLOR(71, 71, 71) forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = kFontOfLetterBig;
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.layer.cornerRadius = _errorBtn.height/2;
        _shareBtn.layer.borderColor = kCOLOR(71, 71, 71).CGColor;
        _shareBtn.layer.borderWidth = 1;
        _shareBtn.tag = 12;
        [self.view addSubview:_shareBtn];
    }
    return _shareBtn;
}
@end
