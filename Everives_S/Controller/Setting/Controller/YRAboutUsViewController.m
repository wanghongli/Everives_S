//
//  YRAboutUsViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/4/19.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAboutUsViewController.h"
#import "UMSocial.h"
@interface YRAboutUsViewController ()
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
                                      shareText:@"蚁人约驾哈哈哈哈"
                                     shareImage:[UIImage imageNamed:@"head_1"]
                                shareToSnsNames:@[UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite]
                                       delegate:nil];
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
@end
