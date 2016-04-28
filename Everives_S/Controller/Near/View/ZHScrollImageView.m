//
//  ZHScrollImageView.m
//  WJHZhiHuDaily
//
//  Created by darkclouds on 16/1/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "ZHScrollImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YRPictureModel.h"
#define kTopImageHeight 213
@interface ZHScrollImageView()<UIScrollViewDelegate>
@end
@implementation ZHScrollImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.imageViews = @[].mutableCopy;
        [self addSubview:self.scrollView];
        
    }
    return self;
    
}

-(void)setModels:(NSArray *)models{
    if (!models.count) {
        return;
    }
    _models = models;
    if (_models.count == 1) {
        self.scrollView.scrollEnabled = NO;
    }
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*(models.count+2), kTopImageHeight);
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];

    for (int i = 0;i<models.count+2;i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, kTopImageHeight)];
        if (i == 0) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:((YRPictureModel*)models[models.count-1]).url] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        }else if (i == models.count+1){
            [imageView sd_setImageWithURL:[NSURL URLWithString:((YRPictureModel*)models[0]).url] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        }else{
           [imageView sd_setImageWithURL:[NSURL URLWithString:((YRPictureModel*)models[i-1]).url] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
        }
       
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    [self addSubview:self.pageControl];
}

#pragma mark UIScrollViewDelegate  //顶部视图横向滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 //   NSLog(@"contentOffsetX %f",scrollView.contentOffset.x);
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    //当前视图是指如果屏幕中只有一个视图就是这个视图，如果有两个视图则是左边那个视图
    _currentPage = ((int)(contentOffsetX/kScreenWidth))-1;
    self.pageControl.currentPage = _currentPage;
    static CGFloat oldContentOffsetX = 0;
    //计算滚动方向
    if (oldContentOffsetX!=0) {
        if (contentOffsetX>oldContentOffsetX) {
            _isScrollingLeft = YES;
        }else{
            _isScrollingLeft = NO;
        }
    }
    oldContentOffsetX = contentOffsetX;
   
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    //如果不会继续滚动
    if (!decelerate) {
        
        //如果超过一半则滚动到下一个视图，否则滚回到当前视图
        if (((int)contentOffsetX)%((int)kScreenWidth)>kScreenWidth/2) {
            [scrollView setContentOffset:CGPointMake((self.currentPage+2)*kScreenWidth, 0) animated:YES];
        }else{
            [scrollView setContentOffset:CGPointMake((self.currentPage+1)*kScreenWidth, 0) animated:YES];
        }
    }
   
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    //如果在向左侧滑动（视图本身）
    if (_isScrollingLeft) {
        [scrollView setContentOffset:CGPointMake((self.currentPage+2)*kScreenWidth, 0) animated:YES];
    }
    else{
        [scrollView setContentOffset:CGPointMake((self.currentPage+1)*kScreenWidth, 0) animated:YES];
    }
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //重点，如果是最后一个视图则悄悄切换到1视图；如果是-1视图则悄悄切换到“源数据”最后一个视图，即倒数第二个视图
    if (_isScrollingLeft&&_currentPage == self.models.count){
        [scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
    }else if (!_isScrollingLeft&&_currentPage == -1) {
        [scrollView setContentOffset:CGPointMake(kScreenWidth*(self.models.count), 0) animated:NO];
    }
}
#pragma mark Getters
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopImageHeight)] ;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/2-50, kTopImageHeight-30, 100, 40)];
        _pageControl.numberOfPages = self.models.count;
    }
    return _pageControl;
}
@end
