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
@interface YRLearnPracticeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _currentID;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *msgArray;
@property (nonatomic, strong) YRPracticeDownView *downView;

@end

@implementation YRLearnPracticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _msgArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self buildUI];
}
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
        UIBarButtonItem *addPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_Cue"] style:UIBarButtonItemStyleBordered target:self action:@selector(addPlace)];
        UIBarButtonItem *searchPlaceBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Learn_CollectionHollow"] style:UIBarButtonItemStyleBordered target:self action:@selector(searchPlace)];
        self.navigationItem.rightBarButtonItems = @[addPlaceBtn,searchPlaceBtn];
    }else if (self.menuTag == 0){//模拟考试
        _downView = [[YRPracticeDownView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kScreenWidth, 44)];
        _downView.numbString = @"12/1234";
        [self.view addSubview:_downView];
    }else if (self.menuTag == 2){
        
    }
        

}
-(void)addPlace
{}
-(void)searchPlace
{}
-(void)getDataWithInsert:(BOOL)insert
{
    if (self.menuTag == 2) {
        [RequestData GET:JK_SJ_PRACTICE parameters:@{@"type":@"0"} complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
            YRQuestionObject *questionOB = [YRQuestionObject mj_objectWithKeyValues:responseDic];
            [_msgArray addObject:questionOB];
            [self.collectionView reloadData];
        } failed:^(NSError *error) {
            
        }];
    }else{
    [RequestData GET:[NSString stringWithFormat:@"/question/question/%ld",_currentID] parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        YRQuestionObject *questionOB = [YRQuestionObject mj_objectWithKeyValues:responseDic];
//        if (insert) {
//            [_msgArray insertObject:questionOB atIndex:0];
//            [self.collectionView reloadData];
//            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
//        }else{
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
        [_msgArray replaceObjectAtIndex:indexPath.row withObject:currentQues];
        [self.collectionView reloadData];
    }];
    if (indexPath.row == _msgArray.count-1) {
        _currentID++;
        [self getDataWithInsert:NO];
    }
//    if (_msgArray.count) {
//        if (indexPath.row == 0 ) {
//            
//            if (ques.id>1) {
//                _currentID--;
//                [self getDataWithInsert:YES];
//            }
//        }
//    }
    if (self.menuTag == 1) {
        self.title = [NSString stringWithFormat:@"%ld/1234",ques.id];
    }else if(self.menuTag == 0){
        _downView.numbString = [NSString stringWithFormat:@"%ld/1234",ques.id];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
