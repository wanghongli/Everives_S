//
//  YRAddFriendVC.m
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRAddFriendVC.h"

@interface YRAddFriendVC ()<UISearchBarDelegate>
@property(nonatomic,strong) UISearchBar *searchBar;
@property(nonatomic,strong) UIButton *phoneContact;
@end

@implementation YRAddFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.phoneContact];

}
-(void)phoneContactBtnClick:(UIButton*)sender{
    
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"请输入驾友用户名或手机号码";
    }
    return _searchBar;
}
-(UIButton *)phoneContact{
    if (!_phoneContact) {
        _phoneContact = [[UIButton alloc] initWithFrame:CGRectMake(8, 112, kScreenWidth-16, 44)];
        [_phoneContact setTitle:@"关注手机联系人" forState:UIControlStateNormal];
        [_phoneContact setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_phoneContact addTarget:self action:@selector(phoneContactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _phoneContact.layer.masksToBounds = YES;
        _phoneContact.layer.cornerRadius = 5;
        _phoneContact.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _phoneContact.layer.borderWidth = 0.5;
    }
    return _phoneContact;
}

#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

@end
