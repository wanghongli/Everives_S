//
//  YRDriveLawController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRDriveLawController.h"
#import "YRDriveLawCell.h"

@interface YRDriveLawController ()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webview;
@property(nonatomic,strong) NSString *urlStr;
@end

@implementation YRDriveLawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _urlStr = [self.title isEqualToString:@"最新法规"]?@"http://120.27.55.225/data/zuixinfagui.html":@"http://120.27.55.225/data/datijiqiao.html";
    [self.view addSubview:self.webview];
    
}

-(UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webview.delegate = self;
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
    }
    return _webview;
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
