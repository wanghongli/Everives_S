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
#import "YRGotScoreController.h"
#import "FMDB.h"
#import "YRFMDBObj.h"
#import "YRQuestionObj.h"
@interface YRLearnPracticeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YRPracticeDownViewDelegate,UIAlertViewDelegate>
{
    NSInteger _showAnswerID;
    NSInteger timeInt;
    NSTimer *timer;
    YRQuestionObj *_currentQuestion;
}
@property (nonatomic, strong) NSMutableArray *errorArray;//错题
@property (nonatomic, strong) NSMutableArray *rightArray;//正确题
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *msgArray;
@property (nonatomic, strong) YRPracticeDownView *downView;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, assign) BOOL menuType;
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
    self.db = [YRFMDBObj initFmdb];
    //yes 科目四 no 科目一
    self.menuType = self.objectFour;
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
       
    }else if (self.menuTag == 0){//模拟考试
        _downView = [[YRPracticeDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kScreenWidth, 44)];
        _downView.delegate = self;
        [self.view addSubview:_downView];
        _countDownBar = [[UIBarButtonItem alloc]initWithTitle:@"30:00" style:UIBarButtonItemStylePlain target:self action:@selector(downBarBtn)];
        self.navigationItem.rightBarButtonItem = _countDownBar;
        timeInt = 30*60;
        [self getTime];
    }else if (self.menuTag == 2){//随机练习

    }
}
-(void)setCollectMsg:(BOOL)collectBool
{
    //显示答案
    UIBarButtonItem *addPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_Cue"] style:UIBarButtonItemStyleBordered target:self action:@selector(showAnswer)];
    // 1    0
    NSString *imgName;
    if (collectBool) {
        imgName = @"Learn_CollectionBlack";
    }else
        imgName = @"Learn_CollectionHollow";
    //收藏
    UIBarButtonItem *searchPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:imgName] style:UIBarButtonItemStyleBordered target:self action:@selector(collectionClick)];
    self.navigationItem.rightBarButtonItems = @[addPlaceBtn,searchPlaceBtn];
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
#pragma mark - timer方法
-(void)handleMaxShowTimer:(NSTimer *)time
{
    [_countDownBar setTitle:[YRPublicMethod publicMethodAccodingIntMsgTurnToTimeString:timeInt]];
    if (timeInt == 0) {//考试结束
        [time invalidate];
    }
}
#pragma mark - 倒计时
-(void)downBarBtn{}
#pragma mark - 显示答案
-(void)showAnswer
{
    _showAnswerID = _currentQuestion.id;
    [self.collectionView reloadData];
}

#pragma mark - 收藏
-(void)collectionClick
{
    
    if (_currentQuestion.collect) {
        [YRFMDBObj changeMsgWithId:_currentQuestion.id withNewMsg:@"collect = 0" withFMDB:self.db];
        [MBProgressHUD showSuccess:@"取消收藏成功" toView:self.view];
        [self setCollectMsg:NO];
        return;
    }
    [YRFMDBObj changeMsgWithId:_currentQuestion.id withNewMsg:@"collect = 1" withFMDB:self.db];
    [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
    [self setCollectMsg:YES];
}
#pragma mark - 获取模拟考试数据
-(void)getExamMsg
{
    NSArray *array = [NSArray arrayWithArray:[YRFMDBObj getShunXuPracticeWithType:self.menuType withFMDB:self.db]];
    NSMutableArray *idArray = [NSMutableArray array];
    _msgArray = [NSMutableArray array];
    for (int i = 0; i<array.count; i++) {
        YRQuestionObj *questionObj = array[arc4random() % array.count];
        if (![idArray containsObject:[NSString stringWithFormat:@"%ld",questionObj.id]]) {
            [idArray addObject:[NSString stringWithFormat:@"%ld",questionObj.id]];
            [_msgArray addObject:questionObj];
            if (self.objectFour) {
                if (idArray.count == 50) {//科目四50题
                    break;
                }
            }else{
                if (idArray.count == 100) {//科目一100题
                    break;
                }
            }
        }
    }
    _downView.numbString = [NSString stringWithFormat:@"1/%ld",_msgArray.count];
}
#pragma mark - 请求数据
-(void)getDataWithInsert:(BOOL)insert
{
    if (self.menuTag == 2) {//随机练习
        _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getShunXuPracticeWithType:self.menuType withFMDB:self.db]];
    }else if (self.menuTag == 0){//模拟考试
        [self getExamMsg];
    }else if(self.menuTag == 1){//顺序练习
        _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getShunXuPracticeWithType:self.objectFour withFMDB:self.db]];
        self.title = [NSString stringWithFormat:@"1/%ld",_msgArray.count];
    }else if(self.menuTag == 3){//专题练习
        _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.objectFour withSearchMsg:[NSString stringWithFormat:@"kind = %ld",self.perfisonalKind] withFMDB:self.db]];
        self.title = [NSString stringWithFormat:@"1/%ld",_msgArray.count];
    }else if (self.menuTag == 4){//错题
        if (self.perfisonalKind == 1) {//全部错题
            _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.menuType withSearchMsg:@"error = 1" withFMDB:self.db]];
        }else//专项错题
            _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.objectFour withSearchMsg:[NSString stringWithFormat:@"kind = %ld and error = 1",self.perfisonalKind] withFMDB:self.db]];
        self.title = [NSString stringWithFormat:@"1/%ld",_msgArray.count];
    }else if (self.menuTag == 5){//收藏
        if (self.perfisonalKind == 1) {//全部错题
            _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.objectFour withSearchMsg:@"collect = 1" withFMDB:self.db]];
        }else//专项错题
            _msgArray = [NSMutableArray arrayWithArray:[YRFMDBObj getPracticeWithType:self.objectFour withSearchMsg:[NSString stringWithFormat:@"kind = %ld and collect = 1",self.perfisonalKind] withFMDB:self.db]];
        self.title = [NSString stringWithFormat:@"1/%ld",_msgArray.count];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.menuTag == 1) {
        if (self.currentID) {
          YRQuestionObj*qusObj = self.msgArray[0];
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentID - qusObj.id+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }    }
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
    YRQuestionObj *ques;
    if (self.menuTag == 2) {
        if (_showAnswerID) {//显示答案时候不取数据
            ques = _currentQuestion;
        }else
            ques = _msgArray[arc4random() % _msgArray.count];
    }else
        ques = _msgArray[indexPath.row];
    _currentQuestion = ques;
    cell.questionOb = ques;
    
    //选择答案后数据的处理
    [cell setAnswerIsClickBlock:^(YRQuestionObj *currentQues) {
        [self chooseAnswerBackToSaveMsg:currentQues withIndexPath:indexPath];
    }];
    //显示答案
    if (_showAnswerID) {
        cell.showAanly = _showAnswerID;
        _showAnswerID = 0;
    }
    if(self.menuTag == 0){//模拟考试显示底部菜单
        _downView.numbString = [NSString stringWithFormat:@"%ld/%ld",indexPath.row+1,_msgArray.count];
        _downView.questObj = ques;
        cell.MNCurrentID = indexPath.row+1;
        cell.examBool = YES;
    }else{
        if (self.menuTag == 1) {
            [YRFMDBObj saveMsgWithMsg:ques.id withType:self.menuType];
        }
        [self setCollectMsg:ques.collect];
        self.title = [NSString stringWithFormat:@"%ld/%ld",indexPath.row+1,_msgArray.count];
    }
    return cell;
}
//选择答案后对数据的处理（刷新与存储）
-(void)chooseAnswerBackToSaveMsg:(YRQuestionObj *)currentQues withIndexPath:(NSIndexPath*)indexPath
{
    NSString *already = [NSString stringWithFormat:@"already = 1"];
    NSString *error = [NSString stringWithFormat:@"error = %d",currentQues.answer == currentQues.chooseAnswer?0:1];
    NSString *chooseAnswer = [NSString stringWithFormat:@"chooseAnswer = %ld",(long)currentQues.chooseAnswer];
    [YRFMDBObj changeMsgWithId:currentQues.id withNewMsg:already withFMDB:self.db];
    [YRFMDBObj changeMsgWithId:currentQues.id withNewMsg:error withFMDB:self.db];
    [YRFMDBObj changeMsgWithId:currentQues.id withNewMsg:chooseAnswer withFMDB:self.db];
    [_msgArray replaceObjectAtIndex:indexPath.row withObject:currentQues];
    if (self.menuTag == 0) {//考试状态选择就跳到下一个题
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        if (currentQues.error) {
            [self.errorArray addObject:currentQues];
        }else
            [self.rightArray addObject:currentQues];
    }else{//练习状态选择正确后跳到下一个题
        if (!currentQues.error) {
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }
    }
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
        [self collectionClick];
    }else{//交卷
        //提交错题
//        [RequestData POST:JK_POST_WRONG parameters:@{@"id":[self.errorArray mj_JSONString]} complete:^(NSDictionary *responseDic) {
//            MyLog(@"%@",responseDic);
//        } failed:^(NSError *error) {
//            
//        }];
        NSInteger scroeInt = self.objectFour ? self.rightArray.count*2:self.rightArray.count;
        NSString *string = [NSString stringWithFormat:@"您已经回答了%ld题，考试得分%ld，确定要交卷吗?",self.errorArray.count+self.rightArray.count,scroeInt];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        YRGotScoreController *adv = [[YRGotScoreController alloc]init];
        NSInteger scroeInt = self.objectFour ? self.rightArray.count*2:self.rightArray.count;
        adv.scroe = scroeInt;
        [self.navigationController pushViewController:adv animated:YES];
    }
}
@end
