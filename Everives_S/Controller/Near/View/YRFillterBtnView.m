//
//  YRFillterBtnView.m
//  Everives_S
//
//  Created by darkclouds on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRFillterBtnView.h"
#import "YRPullListView.h"

@interface YRFillterBtnView(){
    CGFloat _btnWidth;
    NSInteger _btnNum;
    NSInteger _whichBtnClicked;
    NSMutableArray *_pullViews;
    BOOL _ishiden;
}
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,strong) NSMutableArray *btns;
@property(nonatomic,strong) YRPullListView *pullView;
@end
@implementation YRFillterBtnView

-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _btns = @[].mutableCopy;
        _pullViews= @[].mutableCopy;
        _btnNum = _titles.count;
        _btnWidth = frame.size.width/_btnNum;
        _whichBtnClicked = -1;
        _ishiden = YES;
        for (NSInteger i = 0; i<_btnNum; i++) {
            [self addSubview:self.btns[i]];
        }
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        _itemArrs = @[@[@[@"重庆"],@[@"南岸",@"江北",@"渝北",@"渝中",@"北碚",@"巴南",@"沙坪坝"]],
                        @[@[@"综合排序",@"人气最高",@"距离最近",@"评价最好"]]];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removePullView:) name:kFillterBtnRemovePullView object:nil];
    return self;
}

-(void)removePullView:(NSNotification*)notification{
    
    NSString *title = [NSString string];
    for (NSInteger i =0; i<self.pullView.selectedArray.count; i++) {
        title = [title stringByAppendingString:_itemArrs[_whichBtnClicked][i][[self.pullView.selectedArray[i] integerValue]]];
    }
    if (self.pullView.tag == 0) {
        _addr = [title substringFromIndex:2];
    }else{
        _sort = [self.pullView.selectedArray lastObject];
    }
    [_btns[_whichBtnClicked] setTitle:title forState:UIControlStateNormal];
    _ishiden = YES;
    [self.pullView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNearViewControlerReloadTable object:nil];
}

-(NSMutableArray *)btns{
    if (!_btns.count) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_btnWidth*i, 0, _btnWidth, self.frame.size.height)];
            btn.tag = i;
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            if (i==0) {
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
            }
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_btns addObject:btn];
        }
    } 
    return _btns;
}
//显示、隐藏下拉列表
-(void)btnClick:(UIButton*)sender{
    
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj tag] != sender.tag) {
            [obj setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
        }
    }];
    //不是第一次选择 并且点击了另外的按钮
    if (_whichBtnClicked != -1 && _whichBtnClicked != sender.tag) {
        [self.pullView removeFromSuperview];
        _ishiden = YES;
    }
    _whichBtnClicked = sender.tag;
    if (_ishiden) {
        _ishiden = NO;
        [self.superview addSubview:self.pullView];
    }else{
        _ishiden = YES;
        //如果全部选择了有效数据
        [self.pullView removeFromSuperview];
        if (![self.pullView.selectedArray containsObject:@-1]) {
            NSString *title = [NSString string];
            for (NSInteger i =0; i<self.pullView.selectedArray.count; i++) {
                title = [title stringByAppendingString:_itemArrs[_whichBtnClicked][i][[self.pullView.selectedArray[i] integerValue]]];
            }
            if (sender.tag == 0) {
                if ([_addr isEqualToString:[title substringFromIndex:2]]) {
                    return;
                }
                _addr = [title substringFromIndex:2];
                
            }else{
                if ([_sort isEqualToString:[_pullView.selectedArray lastObject]]) {
                    return;
                }
                _sort = [_pullView.selectedArray lastObject];
            }
            [sender setTitle:title forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNearViewControlerReloadTable object:nil];
        }
    }
   
}
-(YRPullListView *)pullView{
    if (!_pullView) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            YRPullListView *pullView = [[YRPullListView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight/4) itemArray:_itemArrs[i]];
            pullView.tag = i;
            [_pullViews addObject:pullView];
        }
    }
    return _pullViews[_whichBtnClicked];
        
}
@end
