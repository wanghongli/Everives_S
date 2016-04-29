//
//  YRSearchBar.m
//  Everives_S
//
//  Created by darkclouds on 16/4/29.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSearchBar.h"

@implementation YRSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = kCOLOR(165, 165, 165).CGColor;
        self.layer.cornerRadius = 22;
        [self addSubview:self.searchBar];
    }
    return self;
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-40, 44)];
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar.showsScopeBar = YES;
        _searchBar.layer.cornerRadius = 22;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.text = @"搜索";
        UIImage *image = [UIImage imageNamed:@"NearMap_Search"];
        [_searchBar setSearchFieldBackgroundImage:image forState:UIControlStateNormal];
        UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 22, 44)];
        left.image = [UIImage imageNamed:@"LeftCircle"];
        [_searchBar addSubview:left];
        UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth-50, 0, 22, 44)];
        right.image = [UIImage imageNamed:@"RightCircle"];
        [_searchBar addSubview:right];
    }
    return _searchBar;
}
@end
