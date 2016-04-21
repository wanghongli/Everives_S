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
@interface YRAboutUsViewController ()<UMSocialUIDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) UIButton *shareBtn;
@end

@implementation YRAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shareBtn];
}

-(void)shareBtnClick:(UIButton*)sender{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUMengAppkey
                                      shareText:@"人的一切痛苦都是对自己无能的愤怒"
                                     shareImage:[UIImage imageNamed:@"head_1"]
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
                                       delegate:self];
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, kScreenHeight-150, kScreenWidth-160, 50)];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor colorWithWhite:0.178 alpha:1.000] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.layer.borderColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1].CGColor;
        _shareBtn.layer.borderWidth = 0.5;
        _shareBtn.layer.cornerRadius = 25;
    }
    return _shareBtn;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
        if (!(KUserManager.first&3)) {
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
@end
