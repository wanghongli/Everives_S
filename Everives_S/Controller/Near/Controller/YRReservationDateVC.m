//
//  YRReservationDateVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationDateVC.h"
#import "YRDateCell.h"
@interface YRReservationDateVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@end
@implementation YRReservationDateVC
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}

static NSString *kCellIdentifier = @"kCellIdentifier";
#pragma mark -UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YRDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    UILabel *text = [[UILabel alloc ]initWithFrame:CGRectMake(0, 0, 120, 60)];
    text.text = @"123";
    [cell.contentView addSubview:text];
    return cell;
}
#pragma mark - Getters
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 1.0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[YRDateCell class] forCellWithReuseIdentifier:kCellIdentifier];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}
@end
