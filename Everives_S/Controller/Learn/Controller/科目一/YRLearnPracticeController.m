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
@interface YRLearnPracticeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *msgArray;
@end

@implementation YRLearnPracticeController

- (void)viewDidLoad {
    [super viewDidLoad];
    _msgArray = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.view.frame.size.height-40) collectionViewLayout:flowlayout];
    flowlayout.minimumLineSpacing = 0;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[YRLearnCollectionCell class] forCellWithReuseIdentifier:@"UIColletionViewCell"];
    
    [self getData];
}
-(void)getData
{
    [RequestData GET:@"/question/question/2" parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        YRQuestionObject *questionOB = [YRQuestionObject mj_objectWithKeyValues:responseDic];
        [_msgArray addObject:questionOB];
        [self.collectionView reloadData];
    } failed:^(NSError *error) {
        
    }];
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
