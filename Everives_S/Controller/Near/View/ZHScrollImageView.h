//
//  ZHScrollImageView.h
//  WJHZhiHuDaily
//
//  Created by darkclouds on 16/1/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHScrollImageView : UIView
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,assign) BOOL isScrollingLeft;
@property(nonatomic,strong) NSArray *models;
@property(nonatomic,assign) id myDelegate;
@property(nonatomic,assign) NSInteger currentPage;
@property(nonatomic,strong) NSMutableArray *imageViews;
-(instancetype)initWithFrame:(CGRect)frame;
@end
