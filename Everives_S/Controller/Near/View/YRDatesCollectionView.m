//
//  YRDatesCollectionView
//  Everives_T
//
//  Created by darkclouds on 16/5/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRDatesCollectionView.h"
#import "UIColor+Tool.h"

#define kdateHeight 50
#define kcellWidth 62.5
#define kCellIdentifier @"reuseID"
static NSInteger sectionNum = 9;//竖着的那种
static NSInteger rowNum = 1; //横着的那种
@interface YRDatesCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSArray *_dateArray;//显示在顶部不带年份
}
@end
@implementation YRDatesCollectionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSomeData];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)initSomeData{
    NSMutableArray *days = @[].mutableCopy;
    for (NSInteger i = 0; i<sectionNum; i++) {
        NSDate *firstDay = [[NSDate date] dateByAddingTimeInterval:3600*24*i];
        NSString *dayStr = [NSString dateStringWithInterval:[NSString stringWithFormat:@"%f",firstDay.timeIntervalSince1970]];
        dayStr = [dayStr substringFromIndex:5];
        [days addObject:dayStr];
    }
    days[0] = @"今天";
    _dateArray = days.copy;
}
#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return rowNum;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return sectionNum;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag ==123) {
            [obj removeFromSuperview];
        }
    }];
    UILabel *dateL = [[UILabel alloc] initWithFrame:CGRectMake(0, kdateHeight/2-10, kcellWidth, 20)];
    dateL.textAlignment = NSTextAlignmentCenter;
    dateL.text = _dateArray[indexPath.section];
    dateL.font = kFontOfLetterMedium;
    if (indexPath.section == 0) {
        dateL.textColor = [UIColor redColor];
    }else{
        dateL.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    }
    dateL.tag = 123;
    [cell.contentView addSubview:dateL];
    cell.backgroundColor = [UIColor colorWithRGB:0xefefef];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
}
#pragma mark - Getters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(kcellWidth, kdateHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

@end
