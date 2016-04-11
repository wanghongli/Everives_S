//
//  YRTeacherMakeCommentController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherMakeCommentController.h"
#import "YRTeacherStarLevelView.h"

#import "JKImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSString+MKNetworkKitAdditions.h"
#import "PhotoCell.h"
#import <QiniuSDK.h>

#import "YRTeacherCommentDetailController.h"
@interface YRTeacherMakeCommentController ()<JKImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
{
    NSMutableDictionary *_bodyDic;
    NSMutableArray *_imgNameArray;
    NSMutableArray *_publishImgArray;
}
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) NSMutableArray   *assetsArray;

@property (nonatomic, strong) YRTeacherStarLevelView *starView;

@end

@implementation YRTeacherMakeCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
    self.view.backgroundColor = [UIColor whiteColor];
    self.starView.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"评价详情" style:UIBarButtonItemStylePlain target:self action:@selector(teacherCommentClick)];
}
-(void)teacherCommentClick
{
    YRTeacherCommentDetailController *detailVC = [[YRTeacherCommentDetailController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)buildUI
{
    _bodyDic = [NSMutableDictionary dictionary];
    _imgNameArray = [NSMutableArray array];
    _publishImgArray = [NSMutableArray array];
    
    UIImage  *img = [UIImage imageNamed:@"pic_add"];
    UIButton   *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetWidth(self.view.frame)-15-img.size.width, 200+(80-img.size.height)/2+64, img.size.width, img.size.height);
    [button setBackgroundImage:img forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_pic_add_highlighted"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(composePicAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIView *textTopLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.starView.frame), kSizeOfScreen.width, 1)];
    textTopLine.backgroundColor = kCOLOR(241, 241, 241);
    [self.view addSubview:textTopLine];
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.starView.frame)+1, kSizeOfScreen.width-30, 170)];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.textView];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.text = @"说点什么吧";
    self.textView.textColor = kCOLOR(200, 200, 200);
    
    
    self.publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), kSizeOfScreen.width, 44)];
    self.publishBtn.backgroundColor = kMainColor;
    [self.publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.publishBtn addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publishBtn];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(15, 200+60, kSizeOfScreen.width-30, 1)];
    topLine.backgroundColor = kCOLOR(241, 241, 241);
    [self.view addSubview:topLine];
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, 200+64+80+4, kSizeOfScreen.width, 1)];
    downLine.backgroundColor = kCOLOR(241, 241, 241);
    [self.view addSubview:downLine];
    [self.view bringSubviewToFront:button];
}

- (void)composePicAdd
{
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 9;
    imagePickerController.selectedAssetArray = self.assetsArray;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [self presentViewController:navigationController animated:YES completion:NULL];
}
-(void)publishClick:(UIButton*)sender
{}
#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    self.assetsArray = [NSMutableArray arrayWithArray:assets];
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
    }];
}

- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

static NSString *kPhotoCellIdentifier = @"kPhotoCellIdentifier";
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.assetsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellIdentifier forIndexPath:indexPath];
    
    cell.asset = [self.assetsArray objectAtIndex:[indexPath row]];
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)[indexPath row]);
    
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5.0;
        layout.minimumInteritemSpacing = 5.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UIImage  *img = [UIImage imageNamed:@"pic_add"];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.textView.frame), CGRectGetWidth(self.view.frame)-30 - img.size.width - 10, 80) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:kPhotoCellIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"说点什么吧"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (!textView.text.length) {
        textView.text = @"说点什么吧";
        textView.textColor = kCOLOR(200, 200, 200);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (YRTeacherStarLevelView *)starView
{
    if (_starView == nil) {
        
        _starView = [[YRTeacherStarLevelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.36)];
        [self.view addSubview:_starView];
        
    }
    return _starView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
