//
//  YRAddWeiboController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAddWeiboController.h"
#import "JKImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "NSString+MKNetworkKitAdditions.h"
#import "PhotoCell.h"
#import <QiniuSDK.h>
#import "YRFriendCircleController.h"
#import "SDImageCache.h"
#import "YRShaHeObjct.h"
@interface YRAddWeiboController ()<JKImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
{
    NSMutableDictionary *_bodyDic;
    NSMutableArray *_imgNameArray;
    NSMutableArray *_publishImgArray;
}
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *publishBtn;
@property (nonatomic, strong) NSMutableArray   *assetsArray;
@property (nonatomic, strong) UIButton *showAddr;//显示位置
@end

@implementation YRAddWeiboController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布";
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
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
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 15+64, kSizeOfScreen.width-30, 170)];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.textView];
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.text = @"说点什么吧";
    self.textView.textColor = kCOLOR(200, 200, 200);
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(15, 200+60, kSizeOfScreen.width-30, 1)];
    topLine.backgroundColor = kCOLOR(241, 241, 241);
    [self.view addSubview:topLine];
    UIView *downLine = [[UIView alloc]initWithFrame:CGRectMake(0, 200+64+80+4, kSizeOfScreen.width, 1)];
    downLine.backgroundColor = kCOLOR(241, 241, 241);
    [self.view addSubview:downLine];
    
    self.showAddr = [[UIButton alloc]initWithFrame:CGRectMake(self.collectionView.x, CGRectGetMaxY(downLine.frame)+10, 80, 20)];
    [self.showAddr setTitle:@" 显示位置" forState:UIControlStateNormal];
    [self.showAddr setTitle:@" 显示位置" forState:UIControlStateSelected];
    [self.showAddr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.showAddr setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self.showAddr setImage:[UIImage imageNamed:@"Neighborhood_Field_Add"] forState:UIControlStateNormal];
    [self.showAddr setImage:[UIImage imageNamed:@"Neighborhood_Field_Add"] forState:UIControlStateSelected];
    [self.showAddr addTarget:self action:@selector(showAddrClick:) forControlEvents:UIControlEventTouchUpInside];
    self.showAddr.layer.masksToBounds = YES;
    self.showAddr.layer.cornerRadius = self.showAddr.height/2;
    self.showAddr.backgroundColor = kCOLOR(238, 239, 240);
    self.showAddr.titleLabel.font = [UIFont systemFontOfSize:12];
    self.showAddr.hidden = YES;
    [self.view addSubview:self.showAddr];
    
    self.publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.showAddr.frame)+30, kSizeOfScreen.width, 44)];
    self.publishBtn.backgroundColor = kMainColor;
    [self.publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.publishBtn addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publishBtn];
}
-(void)showAddrClick:(UIButton *)sender
{
    MyLog(@"%s - %@",__func__,sender);
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
{
    sender.userInteractionEnabled = NO;
    [_imgNameArray removeAllObjects];
    [_publishImgArray removeAllObjects];
    if (!self.textView.text.length) {
        [MBProgressHUD showError:@"内容不能为空" toView:self.view];
        sender.userInteractionEnabled = YES;
        return;
    }else if([self.textView.text isEqualToString:@"说点什么吧"]){
        [MBProgressHUD showError:@"内容不能为空" toView:self.view];
        sender.userInteractionEnabled = YES;
        return;
    }
    NSMutableString *addrString = [NSMutableString stringWithString:KUserLocation.addr];
    if ([addrString containsString:@"ReGeocode: "]) {
        [addrString deleteCharactersInRange:NSMakeRange(0, 10)];
    }
    [_bodyDic setObject:addrString forKey:@"address"];
    [_bodyDic setObject:self.textView.text forKey:@"content"];
    MyLog(@"%@",KUserLocation.addr);
    [MBProgressHUD showMessag:@"上传中..." toView:self.view];
    if (!self.assetsArray.count) {
        NSString *imgArray = [_publishImgArray mj_JSONString];
        [_bodyDic setObject:imgArray forKey:@"pics"];
        [RequestData POST:WEIBO_ADD parameters:_bodyDic complete:^(NSDictionary *responseDic) {
            [self goBackVC];
        } failed:^(NSError *error) {
            sender.userInteractionEnabled = YES;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        return;
    }

    for (int i = 0; i<self.assetsArray.count; i++) {
        JKAssets *jkasset = self.assetsArray[i];
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:jkasset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {
                UIImage *img=[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                NSData *uploadData = UIImageJPEGRepresentation(img, 1);
                NSString *imageName = [[uploadData.description md5] addString:@".jpg"];
                [_imgNameArray addObject:imageName];
                [_publishImgArray addObject:[NSString stringWithFormat:@"%@%@",QINIU_SERVER_URL,imageName]];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [YRShaHeObjct saveNSDictionaryForDocument:uploadData FileUrl:imageName];
                    [[SDImageCache sharedImageCache] storeImage:[UIImage imageWithData:uploadData] forKey:imageName];
                    MyLog(@"time-------addimg");
                });
                
                if (_imgNameArray.count == self.assetsArray.count) {
                    NSString *imgArray = [_publishImgArray mj_JSONString];
                    [_bodyDic setObject:imgArray forKey:@"pics"];
                    [self publishImages:_imgNameArray];
                    [RequestData POST:WEIBO_ADD parameters:_bodyDic complete:^(NSDictionary *responseDic) {
                        sender.userInteractionEnabled = YES;
                        if (_imgNameArray.count) {
                            [self goBackVC];
                        }else{
                            [self goBackVC];
                        }
                    } failed:^(NSError *error) {
                        sender.userInteractionEnabled = YES;
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                    }];
                }
            }
        } failureBlock:^(NSError *error) {
            sender.userInteractionEnabled = YES;
        }];
    }
}
-(void)goBackVC
{
    [self performSelector:@selector(goBackVC1) withObject:nil afterDelay:_imgNameArray.count];
    
}
-(void)goBackVC1
{
    YRFriendCircleController *fcVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    fcVC.refreshMsg = @"刷新数据";
    [self.navigationController popToViewController:fcVC animated:YES];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)publishImages:(NSArray *)imgName
{
    [RequestData GET:USER_QINIUTOKEN parameters:nil complete:^(NSDictionary *responseDic) {
        //获取token
        MyLog(@"%@",responseDic);
        NSString *token = responseDic[@"token"];
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        for (int i = 0; i<self.assetsArray.count; i++) {
            JKAssets *jkasset = self.assetsArray[i];
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            [lib assetForURL:jkasset.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    UIImage *img=[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                    NSData *uploadData = UIImageJPEGRepresentation(img, 1);
                    //上传到七牛
                    [upManager putData:uploadData key:imgName[i] token:token
                              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                                  NSLog(@"%@\n---%@\n %@",info,resp,key);
                                  if (resp) {
                                      if (i == self.assetsArray.count-1) {
//                                          [MBProgressHUD showSuccess:@"上传成功" toView:self.navigationController.view];
                                          
                                      }
                                  }
                                  
                              } option:nil];
                }
            } failureBlock:^(NSError *error) {
                
            }];
        }
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 200+64, CGRectGetWidth(self.view.frame)-30 - img.size.width - 10, 80) collectionViewLayout:layout];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
