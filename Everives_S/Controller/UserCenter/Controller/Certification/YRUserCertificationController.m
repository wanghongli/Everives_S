//
//  YRUserCertificationController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/5/30.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserCertificationController.h"
#import "CorePhotoPickerVCManager.h"
#import "UIImage+Tool.h"
#import <QiniuSDK.h>
#import "NSString+MKNetworkKitAdditions.h"
#import "PublicCheckMsgModel.h"
@interface YRUserCertificationController ()<UIActionSheetDelegate>

@end

@implementation YRUserCertificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    self.selectBtn.layer.masksToBounds = YES;
    self.selectBtn.layer.borderColor = kCOLOR(224, 225, 225).CGColor;
    self.selectBtn.layer.borderWidth = 1;
    _doneClick.layer.cornerRadius = 22;
    
    if (self.scrollView.height<CGRectGetMaxY(self.doneClick.frame)+10) {
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.doneClick.frame)+10);
    }else
        self.scrollView.contentSize = CGSizeMake(kScreenWidth, self.scrollView.height);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)addCarIDImg:(UIButton *)sender {
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:self.view];
    
}
- (IBAction)addMsgClick:(UIButton *)sender {
    
    [PublicCheckMsgModel checkName:self.nameText.text idCard:self.carIDtext.text complete:^(BOOL isSuccess) {
        [MBProgressHUD showMessag:@"提交中..." toView:self.view];

        [RequestData GET:USER_QINIUTOKEN parameters:nil complete:^(NSDictionary *responseDic) {
            //获取token
            MyLog(@"%@",responseDic);
            NSString *token = responseDic[@"token"];
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            UIImage *img = self.selectImg.image;
            
            NSData *uploadData = UIImageJPEGRepresentation(img, 1);
            NSString *imageName = [[uploadData.description md5] addString:@".jpg"];
            
            //上传到七牛
            [upManager putData:uploadData key:imageName token:token
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          NSLog(@"%@\n---%@\n %@",info,resp,key);
                          if (resp) {
                              NSLog(@"%@,%@,%@",self.nameText.text,self.carIDtext.text,imageName);
                              [RequestData POST:STUDENT_IDENTIFY parameters:@{@"realname":self.nameText.text,@"peopleId":self.carIDtext.text,@"peoplePic":imageName} complete:^(NSDictionary *responseDic) {
                                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                  [MBProgressHUD showSuccess:@"信息已提交，正在等待审核" toView:GET_WINDOW];
                                  [self.navigationController popViewControllerAnimated:YES];
                                  KUserManager.status = 0;
                                  KUserManager.peopleId = self.carIDtext.text;
                                  KUserManager.realname = self.nameText.text;
                                  [YRPublicMethod changeUserMsgWithKeys:@[@"checked",@"peopleId",@"realname"] values:@[@(0),self.carIDtext.text,self.nameText.text]];
                                  
                              } failed:^(NSError *error) {
                                  [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                  [MBProgressHUD showError:@"认证失败,请重新提交" toView:GET_WINDOW];
                              }];
                          }
                          
                      } option:nil];
        } failed:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    } error:^(NSString *errorMsg) {
        [MBProgressHUD showError:errorMsg toView:GET_WINDOW];
    }];
    
}

#pragma mark - 选择头像
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
        CorePhotoPickerVCMangerType type=0;
        if (buttonIndex == 0) {
            type=CorePhotoPickerVCMangerTypeSinglePhoto;
        } else if (buttonIndex == 1){
            type=CorePhotoPickerVCMangerTypeCamera;
        }else{
            return;
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
            self.selectImg.image = image;
            [self.selectBtn setImage:nil forState:UIControlStateNormal];
        };
        [self presentViewController:pickerVC animated:YES completion:nil];
}
@end
