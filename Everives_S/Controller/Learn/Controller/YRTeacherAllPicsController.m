//
//  YRTeacherAllPicsController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/19.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherAllPicsController.h"
#import "YRTeacherAllPicsCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface YRTeacherAllPicsController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *picArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation YRTeacherAllPicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部照片";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
}
-(void)getData
{
    [MBProgressHUD showMessag:@"加载中..." toView:self.view];
    [RequestData GET:[NSString stringWithFormat:@"/account/teacherPics/%ld",self.teacherID] parameters:nil complete:^(NSDictionary *responseDic) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        _picArray = [NSArray arrayWithArray:(NSArray *)responseDic];
        MyLog(@"%@",_picArray);
        [self buildUI];
    } failed:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
-(void)buildUI
{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    CGFloat itemWH = (kScreenWidth-10)/2;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kSizeOfScreen.height-64) collectionViewLayout:layout];
    //代理设置
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    //注册item类型 这里使用系统的类型
//    [self.collectionView registerClass:[YRTeacherAllPicsCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YRTeacherAllPicsCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    
    [self.view addSubview:self.collectionView];
}
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _picArray.count;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YRTeacherAllPicsCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell.imgVIew sd_setImageWithURL:[NSURL URLWithString:_picArray[indexPath.row]] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    YRTeacherAllPicsCell *cell = (YRTeacherAllPicsCell*)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *tapView = cell.imgVIew;
    // CZPhoto -> MJPhoto
    int i = 0;
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSString *photo in _picArray) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *urlStr = photo;
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
    }
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    brower.photos = arrM;
    brower.currentPhotoIndex = indexPath.row;
    [brower show];
}
@end
