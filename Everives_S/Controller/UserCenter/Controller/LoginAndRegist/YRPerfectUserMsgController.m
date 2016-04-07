//
//  YRPerfectUserMsgController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/10.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPerfectUserMsgController.h"
#import "UIView+SDAutoLayout.h"
#import "YRPerfectHeadView.h"
#import "CWSLoginTextField.h"
#import "YRSexChoose.h"
#import "CorePhotoPickerVCManager.h"
#import "CWSPublicButton.h"
#import "UIImage+Tool.h"
#import <QiniuSDK.h>
#import "NSString+MKNetworkKitAdditions.h"
#import <RongIMKit/RongIMKit.h>
#import "YRUserStatus.h"
#define kDistace 10
@interface YRPerfectUserMsgController ()<UIScrollViewDelegate,YRPerfectHeadViewDelegate,UIActionSheetDelegate,YRSexChooseDelegate>
{
    NSMutableDictionary *_bodyDic;
}
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) YRPerfectHeadView *headView;

@property (nonatomic, strong) CWSLoginTextField *nickName;

@property (nonatomic, strong) CWSLoginTextField *ageText;

@property (nonatomic, strong) YRSexChoose *sexView;

@property (nonatomic, strong) CWSPublicButton *saveBtn;

@property (nonatomic, strong) CWSPublicButton *noSaveBtn;
@end

@implementation YRPerfectUserMsgController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    self.view.backgroundColor = [UIColor whiteColor];
    _bodyDic = [NSMutableDictionary dictionary];
    [self buildUI];
}
#pragma mark - 创建视图
-(void)buildUI
{
    _headView = [[YRPerfectHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*0.6)];
    _headView.delegate = self;
    _headView.image = [UIImage imageNamed:@"background_1"];
    [self.view addSubview:_headView];
    
    _nickName = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistace*2, CGRectGetMaxY(_headView.frame)+kDistace, self.view.width-4*kDistace, 44)];
    _nickName.placeholder = @"请输入昵称";
    _nickName.leftString = @"昵称";
    [self.view addSubview:_nickName];
    
    _ageText = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(kDistace*2, CGRectGetMaxY(_nickName.frame)+kDistace, _nickName.width, _nickName.height)];
    _ageText.placeholder = @"请选择年龄";
    _ageText.leftString = @"年龄";
    [self.view addSubview:_ageText];
    
    _sexView = [[YRSexChoose alloc]initWithFrame:CGRectMake(_ageText.x, CGRectGetMaxY(_ageText.frame)+kDistace, _ageText.width, _ageText.height)];
    _sexView.delegate = self;
    [self.view addSubview:_sexView];
    
    _saveBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(_ageText.x, CGRectGetMaxY(_sexView.frame)+kDistace, _ageText.width, _ageText.height)];
    [_saveBtn setTitle:@"填写完成" forState:UIControlStateNormal];
    [_saveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.tag = 10;
    [self.view addSubview:_saveBtn];
    
    _noSaveBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(_ageText.x, CGRectGetMaxY(_saveBtn.frame)+kDistace, _ageText.width, _ageText.height)];
    [_noSaveBtn setTitle:@"暂时不想填写" forState:UIControlStateNormal];
    [_noSaveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _noSaveBtn.tag = 11;
    [self.view addSubview:_noSaveBtn];
    
}
#pragma mark - 选择头像
-(void)perfectHeadViewChooseImg
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    actionSheet.tag = 100;
    [actionSheet showInView:self.view];
}
//性别选择
-(void)sexChooseTag:(int)sexTag
{
    if (sexTag == 0) {
        [_bodyDic setObject:@"0" forKey:@"gender"];
    }else{
        [_bodyDic setObject:@"1" forKey:@"gender"];
    }
}
#pragma mark - 按钮点击事件
-(void)btnClick:(CWSPublicButton *)sender
{
    if (sender.tag == 10) {//填写完成
        [MBProgressHUD showMessag:@"提交中..." toView:self.view];
        [_bodyDic setObject:self.nickName.text forKey:@"name"];
        [_bodyDic setObject:self.ageText.text forKey:@"age"];
        [_bodyDic setObject:@"主人太懒，什么都没有留下" forKey:@"sign"];
        [RequestData PUT:STUDENT_INFO parameters:_bodyDic complete:^(NSDictionary *responseDic) {
            KUserManager.age = self.ageText.text;
            KUserManager.name = self.nickName.text;
            KUserManager.gender = _bodyDic[@"gender"];
            KUserManager.sign = _bodyDic[@"sign"];
            [YRPublicMethod changeUserMsgWithKeys:@[@"name",@"sign",@"age",@"gender"] values:@[_nickName.text,KUserManager.sign,_ageText.text,KUserManager.gender]];

            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            [MBProgressHUD showSuccess:@"提交成功" toView:GET_WINDOW];
        } failed:^(NSError *error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [MBProgressHUD showSuccess:@"提交失败" toView:GET_WINDOW];
        }];
    }else{//暂时不想填写
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 选择头像
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    CorePhotoPickerVCMangerType type=0;
    if (buttonIndex == 0) {
        
        type=CorePhotoPickerVCMangerTypeSinglePhoto;
    } else if (buttonIndex == 1){
        type=CorePhotoPickerVCMangerTypeCamera;
    }
    CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
    //设置类型
    manager.pickerVCManagerType=type;
    //最多可选3张
    manager.maxSelectedPhotoNumber=1;
    //错误处理
    if(manager.unavailableType!=CorePhotoPickerUnavailableTypeNone){
        [MBProgressHUD showError:@"多媒体不可用！" toView:self.view];
        return;
    }
    UIViewController *pickerVC=manager.imagePickerController;
    //选取结束
    manager.finishPickingMedia=^(NSArray *medias){
        
        CorePhoto *photo = [medias lastObject];
        UIImage *image = [photo.editedImage compressedImage];
        _headView.userImg = image;
        [self uploadImage:image];
    };
    [self presentViewController:pickerVC animated:YES completion:nil];
}
#pragma mark - 上传图片
-(void)uploadImage:(UIImage *)img
{
    [RequestData GET:USER_QINIUTOKEN parameters:nil complete:^(NSDictionary *responseDic) {
        //获取token
        NSString *token = responseDic[@"token"];
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        NSData *uploadData = UIImagePNGRepresentation([self OriginImage:img scaleToSize:CGSizeMake(200, 200)]);
        NSString *imageName = [[uploadData.description md5] addString:@".jpg"];
        
        //上传到七牛
        [upManager putData:uploadData key:imageName token:token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      //提交用户数据
                      
                          [RequestData PUT:STUDENT_AVATAR parameters:@{@"avatar":[NSString stringWithFormat:@"%@%@",QINIU_SERVER_URL,imageName]} complete:^(NSDictionary *responseDic) {
                              KUserManager.avatar = [NSString stringWithFormat:@"%@%@",QINIU_SERVER_URL,imageName];
                              [YRPublicMethod changeUserMsgWithKeys:@[@"avatar"] values:@[[NSString stringWithFormat:@"%@%@",QINIU_SERVER_URL,imageName]]];
                              [MBProgressHUD showSuccess:@"头像修改成功" toView:GET_WINDOW];
                          } failed:^(NSError *error) {
                              
                          }];
                      
                  } option:nil];
    } failed:^(NSError *error) {
        
    }];
}
#pragma mark - 设置头像图片大小
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
@end
