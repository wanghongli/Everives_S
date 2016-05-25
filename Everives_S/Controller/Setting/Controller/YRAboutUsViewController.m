//
//  YRAboutUsViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/4/19.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAboutUsViewController.h"
#import "UMSocial.h"
#import "RequestData.h"
#import "YRMyWalletViewController.h"

#define kLogoStartY 70
@interface YRAboutUsViewController ()<UMSocialUIDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UIButton *shareBtn;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *nameL;
@property(nonatomic,strong) UILabel *versionL;
@end

@implementation YRAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageV];
    [self.view addSubview:self.nameL];
    [self.view addSubview:self.versionL];
    [self.view addSubview:self.shareBtn];
    
}

-(void)shareBtnClick:(UIButton*)sender{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMengShareAppkey
                                      shareText:@"蚁众约驾，开启预约学车新模式"
                                     shareImage:[UIImage imageNamed:@"logo圆角版1"]
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
                                       delegate:self];
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        //如果是第一次分享
        if (!(KUserManager.first&2)) {
            [RequestData GET:ACTIVITY_FIRST parameters:@{@"type":@"1"} complete:^(NSDictionary *responseDic) {
                NSString *message = [NSString stringWithFormat:@"第一次分享，系统奖励学车币%@个",responseDic[@"info"]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"查看我的学车币", nil];
                [alert show];
                //将标志位置为1
                KUserManager.first = KUserManager.first+2;
            } failed:^(NSError *error) {
                
            }];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
        
    }
}

#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        YRMyWalletViewController *wallet = [[YRMyWalletViewController alloc] init];
        [self.navigationController pushViewController:wallet animated:YES];
    }
}
#pragma Getters
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, kScreenHeight-250, kScreenWidth-160, 50)];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor colorWithWhite:0.178 alpha:1.000] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.layer.borderColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1].CGColor;
        _shareBtn.layer.borderWidth = 0.5;
        _shareBtn.layer.cornerRadius = 25;
    }
    return _shareBtn;
}
-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, kLogoStartY, 200, 200)];
        _imageV.image = [UIImage imageNamed:@"logo圆角版1"];
    }
    return _imageV;
}
-(UILabel *)nameL{
    if (!_nameL) {
        _nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 210+kLogoStartY, kScreenWidth, 20)];
        _nameL.text = @"蚁众约驾";
        _nameL.font = kFontOfLetterMedium;
        _nameL.textAlignment = NSTextAlignmentCenter;
    }
    return _nameL;
}
-(UILabel *)versionL{
    if (!_versionL) {
        _versionL = [[UILabel alloc] initWithFrame:CGRectMake(0, 238+kLogoStartY, kScreenWidth, 20)];
        // 当前应用软件版本  比如：1.0.1
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _versionL.text = [NSString stringWithFormat:@"version %@",appCurVersion];
        _versionL.textColor = kTextlightGrayColor;
        _versionL.font = kFontOfLetterSmall;
        _versionL.textAlignment = NSTextAlignmentCenter;
    }
    return _versionL;
}
@end
