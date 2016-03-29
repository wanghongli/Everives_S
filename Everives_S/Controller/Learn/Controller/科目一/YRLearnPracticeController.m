//
//  YRLearnPracticeController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnPracticeController.h"
#import "YRLearnCollectionCell.h"
#import "YRQuestionObject.h"
#include "YRPracticeDownView.h"
//#import "YRAchievementDetailController.h"
#import "YRGotScoreController.h"
@interface YRLearnPracticeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YRPracticeDownViewDelegate,UIAlertViewDelegate>
{
    NSInteger _currentID;
    NSInteger timeInt;
    NSTimer *timer;
    
    
}
@property (nonatomic, strong) NSMutableArray *errorArray;//错题
@property (nonatomic, strong) NSMutableArray *rightArray;//正确题
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *msgArray;
@property (nonatomic, strong) YRPracticeDownView *downView;

/*
*   模拟考试倒计时
*/
@property (nonatomic, strong) UIBarButtonItem *countDownBar;

@end

@implementation YRLearnPracticeController
-(NSMutableArray *)errorArray
{
    if (_errorArray == nil) {
        _errorArray = [NSMutableArray array];
    }
    return _errorArray;
}
-(NSMutableArray *)rightArray{
    if (_rightArray == nil) {
        _rightArray = [NSMutableArray array];
    }
    return _rightArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _msgArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self buildUI];
}
#pragma mark - 创建视图
-(void)buildUI
{
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    CGFloat collectHeight = self.menuTag ? 0:30;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.view.frame.size.height-40-collectHeight) collectionViewLayout:flowlayout];
    flowlayout.minimumLineSpacing = 0;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.collectionView];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[YRLearnCollectionCell class] forCellWithReuseIdentifier:@"UIColletionViewCell"];
    [self getDataWithInsert:NO];
    
    if (self.menuTag == 1) {//顺序练习
        //显示答案
        UIBarButtonItem *addPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_Cue"] style:UIBarButtonItemStyleBordered target:self action:@selector(showAnswer)];
        //收藏
        UIBarButtonItem *searchPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_CollectionHollow"] style:UIBarButtonItemStyleBordered target:self action:@selector(collectionClick)];
        self.navigationItem.rightBarButtonItems = @[addPlaceBtn,searchPlaceBtn];
    }else if (self.menuTag == 0){//模拟考试
        _downView = [[YRPracticeDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kScreenWidth, 44)];
        _downView.delegate = self;
        [self.view addSubview:_downView];
        _countDownBar = [[UIBarButtonItem alloc]initWithTitle:@"30:00" style:UIBarButtonItemStylePlain target:self action:@selector(downBarBtn)];
        self.navigationItem.rightBarButtonItem = _countDownBar;
        timeInt = 30*60;
        [self getTime];
    }else if (self.menuTag == 2){
        
    }
}
-(void)getTime
{
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(handleMaxShowTimer:)
                                            userInfo:nil
                                             repeats:YES];
    [timer fire];
}
-(void)handleMaxShowTimer:(NSTimer *)time
{
    timeInt--;
    int hour = (int)timeInt/3600;
    NSString *hourString = hour>9 ? [NSString stringWithFormat:@"%d",hour] : [NSString stringWithFormat:@"0%d",hour];
    int minute = timeInt%3600/60;
    NSString *minuteString = minute>9 ? [NSString stringWithFormat:@"%d",minute] : [NSString stringWithFormat:@"0%d",minute];
    int second = timeInt%60%60;
    NSString *secondString = minute>9 ? [NSString stringWithFormat:@"%d",second] : [NSString stringWithFormat:@"0%d",second];
    NSString *textString;
    if (hour<1) {
        if (minute<1) {
            textString = [NSString stringWithFormat:@"%@",secondString];
        }else
            textString = [NSString stringWithFormat:@"%@:%@",minuteString,secondString];
    }else{
        textString = [NSString stringWithFormat:@"%@:%@:%@",hourString,minuteString,secondString];
    }
    [_countDownBar setTitle:textString];
    if (timeInt == 0) {
        [time invalidate];
    }
}
#pragma mark - 倒计时
-(void)downBarBtn{}
#pragma mark - 显示答案
-(void)showAnswer
{
}

#pragma mark - 收藏
-(void)collectionClick
{
    
}
#pragma mark - 请求数据
-(void)getDataWithInsert:(BOOL)insert
{
    if (self.menuTag == 2) {//随机练习
        [RequestData GET:JK_SJ_PRACTICE parameters:@{@"type":@"0"} complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
            YRQuestionObject *questionOB = [YRQuestionObject mj_objectWithKeyValues:responseDic];
            [_msgArray addObject:questionOB];
            [self.collectionView reloadData];
        } failed:^(NSError *error) {
            
        }];
    }else if (self.menuTag == 0){//模拟考试
    
        [RequestData GET:JK_MN_PRACTICE parameters:@{@"type":@"0"} complete:^(NSDictionary *responseDic) {
            NSArray *user = [YRQuestionObject mj_objectArrayWithKeyValuesArray:(NSArray *)responseDic];
            MyLog(@"%@",user);
            _msgArray = [NSMutableArray arrayWithArray:user];
            _downView.numbString = [NSString stringWithFormat:@"1/%ld",_msgArray.count];;

            [self.collectionView reloadData];
        } failed:^(NSError *error) {
            
        }];
        
    }else{
        [RequestData GET:[NSString stringWithFormat:@"/question/question/%ld",_currentID] parameters:nil complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
            YRQuestionObject *questionOB = [YRQuestionObject mj_objectWithKeyValues:responseDic];
            [_msgArray addObject:questionOB];
            [self.collectionView reloadData];
            //        }
        } failed:^(NSError *error) {
            
        }];
    }
}
#pragma mark - UIColletionViewDataSource
//定义展示的UIColletionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _msgArray.count;
}
//定义展示的section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UIColletionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UIColletionViewCell";
    
    YRLearnCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    YRQuestionObject *ques = _msgArray[indexPath.row];
    cell.questionOb = ques;
    [cell setAnswerIsClickBlock:^(YRQuestionObject *currentQues) {
        if (currentQues.chooseAnswer.integerValue == currentQues.answer) {//正确
            if (![self.rightArray containsObject:[NSString stringWithFormat:@"%ld",currentQues.id]]) {
                if ([self.errorArray containsObject:[NSString stringWithFormat:@"%ld",currentQues.id]]) {
                    [self.errorArray removeObject:[NSString stringWithFormat:@"%ld",currentQues.id]];
                }
                [self.rightArray addObject:[NSString stringWithFormat:@"%ld",currentQues.id]];
            }
        }else{//错误
            if (![self.errorArray containsObject:[NSString stringWithFormat:@"%ld",currentQues.id]]) {
                //先移除争取里面的
                if ([self.rightArray containsObject:[NSString stringWithFormat:@"%ld",currentQues.id]]) {
                    [self.rightArray removeObject:[NSString stringWithFormat:@"%ld",currentQues.id]];
                }
                [self.errorArray addObject:[NSString stringWithFormat:@"%ld",currentQues.id]];
            }
        }
        [_msgArray replaceObjectAtIndex:indexPath.row withObject:currentQues];
        [self.collectionView reloadData];
    }];
    
    if (self.menuTag == 1) {
        if (indexPath.row == _msgArray.count-1) {
            _currentID++;
            [self getDataWithInsert:NO];
        }
        self.title = [NSString stringWithFormat:@"%ld/1234",ques.id];
    }else if(self.menuTag == 0){
        _downView.numbString = [NSString stringWithFormat:@"%ld/%ld",indexPath.row+1,_msgArray.count];
        _downView.questObj = ques;
        cell.MNCurrentID = indexPath.row+1;
    }
    return cell;
}

#pragma mark - UIColletcionViewDelegateFlowLayout
//定义每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, collectionView.height);
}
//定义每个UIColletionView的margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//返回这个UIColletionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - 模拟考试底部收藏和交卷代理方法
-(void)praciceDownViewBtnClick:(NSInteger)btnTag with:(NSString *)quesID
{
    if (btnTag == 1) {//收藏
        NSString *quesid = [@[quesID] mj_JSONString];
        [RequestData POST:JK_Get_COLLECT parameters:@{@"id":quesid} complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
        } failed:^(NSError *error) {
            
        }];
    }else{//交卷
        //提交错题
        [RequestData POST:JK_POST_WRONG parameters:@{@"id":[self.errorArray mj_JSONString]} complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
        } failed:^(NSError *error) {
            
        }];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确认提交" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
        [alert show];
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        YRGotScoreController *adv = [[YRGotScoreController alloc]init];
        CGFloat fenshu = (CGFloat)self.rightArray.count/(CGFloat)self.msgArray.count;
        adv.scroe = fenshu*100;
        [self.navigationController pushViewController:adv animated:YES];
    }
}
@end
