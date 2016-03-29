//
//  YREditUserController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YREditUserController.h"
#import "CorePhotoPickerVCManager.h"
#import "UIImage+Tool.h"
#import <QiniuSDK.h>
#import "NSString+MKNetworkKitAdditions.h"
#import "YRUserStatus.h"
#import "UIImageView+WebCache.h"

@interface YREditUserController ()<UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    NSMutableDictionary *_bodyDic;
    NSString *_sexString;
}
@property (nonatomic, strong) YRUserStatus *userMsg;

@end

@implementation YREditUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    self.baseView.frame = CGRectMake(0, 66, kScreenWidth, self.baseView.height);
    [self.view addSubview:self.baseView];
    _bodyDic = [NSMutableDictionary dictionary];
    
    [self buildUI];
    
    [self getData];
}
-(void)buildUI
{
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = self.headImg.height/2;
    self.headBtn.layer.masksToBounds = YES;
    self.headBtn.layer.cornerRadius = self.headBtn.height/2;
    self.headBtn.layer.borderWidth = 1;
    self.headBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.editBtn.layer.masksToBounds = YES;
    self.editBtn.layer.cornerRadius = self.editBtn.height/2;
    [self setLayerWithView:self.manBack with:self.manCenter];
    [self setLayerWithView:self.womenBack with:self.womenCenter];
}
-(void)getData
{
    [RequestData GET:STUDENT_GET_INFO parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        _userMsg = [YRUserStatus mj_objectWithKeyValues:responseDic];
        //头像
        [_headImg sd_setImageWithURL:[NSURL URLWithString:_userMsg.avatar] placeholderImage:[UIImage imageNamed:@"backImg"]];
        //昵称
        _nickNameText.text = _userMsg.name;
        //性别
        self.manCenter.hidden = [_userMsg.gender boolValue];
        self.womenCenter.hidden = !self.manCenter.hidden;
        _sexString = _userMsg.gender;
        //年龄
        self.ageText.text = _userMsg.age;
        //简介
        if (_userMsg.sign.length) {
            self.signText.textColor = [UIColor blackColor];
            self.signText.text = _userMsg.sign;
        }else{
            self.signText.text = @"请输入个人简介";
            self.signText.textColor = kCOLOR(241, 241, 241);
        }
    } failed:^(NSError *error) {
        
    }];
}
-(void)setLayerWithView:(UIView*)view with:(UIView *)view1
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 10;
    view.layer.borderWidth = 2;
    view.layer.borderColor = [UIColor colorWithRed:168/255.0 green:205/255.0 blue:252/255.0 alpha:1].CGColor;
    
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 5;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.baseView endEditing:YES];
    return YES;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入个人简介"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (!textView.text.length) {
        textView.text = @"请输入个人简介";
        textView.textColor = kCOLOR(241, 241, 241);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.baseView endEditing:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [textView resignFirstResponder];
//        if (self.baseView.height>self.view.height) {
//            self.scrollView.contentSize = CGSizeMake(0, self.baseView.height);
//        }else{
//            self.scrollView.contentSize = CGSizeMake(0, self.view.height);
//        }
        return NO;
    }
    
    return YES;
}
- (IBAction)sexChoose:(UIButton *)sender {
    if (sender.tag == 21) {//男
        self.manCenter.hidden = NO;
        self.womenCenter.hidden = YES;
        _sexString = @"0";
    }else if(sender.tag == 22){//女
        self.manCenter.hidden = YES;
        self.womenCenter.hidden = NO;
        _sexString = @"1";
    }
}
#pragma mark - 修改头像
- (IBAction)headBtn:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    actionSheet.tag = 100;
    [actionSheet showInView:self.view];
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
        _headImg.image = image;
        //上传头像
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
        //        NSString *imgName = [NSString stringWithFormat:@"face%f",[[NSDate date] timeIntervalSince1970]];
        NSString *imageName = [[uploadData.description md5] addString:@".jpg"];
        
        //上传到七牛http://7xn7nj.com2.z0.glb.qiniucdn.com/
        [upManager putData:uploadData key:imageName token:token
                  complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                      //提交用户数据
                      [RequestData PUT:STUDENT_AVATAR parameters:@{@"avatar":[NSString stringWithFormat:@"%@%@",QINIU_SERVER_URL,imageName]} complete:^(NSDictionary *responseDic) {
                          NSLog(@"%@",responseDic);
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
#pragma mark - 确认修改
- (IBAction)sureClick:(id)sender {
    //判断昵称
    if (!self.nickNameText.text.length) {
        [MBProgressHUD showError:@"大虾，给个昵称呗" toView:self.view];
        return;
    }else{
        if (![self isChinesecharacter:self.nickNameText.text]) {
            [MBProgressHUD showError:@"昵称只能含中文,字母,数字" toView:self.view];
            return;
        }else{
            if (self.nickNameText.text.length>16) {
                [MBProgressHUD showError:@"昵称长度必须在15字符长度内" toView:self.view];
                return;
            }
        }
    }
    [_bodyDic setObject:self.nickNameText.text forKey:@"name"];
//    [_bodyDic setObject:[NSString stringWithFormat:@"%ld",(long)_sexInteger] forKey:@"gender"];
    //判断性别
    [_bodyDic setObject:_sexString forKey:@"gender"];
    //判断年龄
    [_bodyDic setObject:self.ageText.text forKey:@"age"];
    //判断介绍
    if ([self.signText.text isEqualToString:@"请输入个人简介"]) {
        [_bodyDic setObject:@"" forKey:@"sign"];
    }else
        [_bodyDic setObject:self.signText.text forKey:@"sign"];
    
    [RequestData PUT:STUDENT_INFO parameters:_bodyDic complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        KUserManager.name = _nickNameText.text;
        KUserManager.sign = _signText.text;
        [MBProgressHUD showSuccess:@"修改成功" toView:GET_WINDOW];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError *error) {
        
    }];

}
//判断是否为汉字
- (BOOL)isChinesecharacter:(NSString *)string{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        NSString * regex = @"^[A-Za-z0-9\u4e00-\u9fa5]+$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isMatch = [pred evaluateWithObject:string];
        if (isMatch) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}
@end
