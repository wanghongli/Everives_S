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
    BOOL _ishiden;
}
@property(nonatomic,strong) NSMutableArray *pullViews;
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
        self.layer.borderWidth = 0.5;
        self.backgroundColor = [UIColor whiteColor];
        [self addMyObserver];
    }
    return self;
}
-(void)addMyObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removePullView:) name:kFillterBtnRemovePullView object:nil];
    _hasObserver = YES;
}
-(void)removeMyObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFillterBtnRemovePullView object:nil];
    _hasObserver = NO;
}
//全部选择之后自动收缩选项
-(void)removePullView:(NSNotification*)notification{
    _ishiden = YES;
    [self.pullView removeFromSuperview];
    //当前选择按钮的title，比如渝北、人气最高、科目二
    NSString *title = [NSString string];
    for (NSInteger i =0; i<self.pullView.selectedArray.count; i++) {
        title = [title stringByAppendingString:_itemArrs[_whichBtnClicked][i][[self.pullView.selectedArray[i] integerValue]]];
    }
    if (self.pullView.tag == 0) {//地区
        if ([_addr isEqualToString:[title substringFromIndex:2]]) {
            return;
        }
        _addr = [title substringFromIndex:2];
    }else if(self.pullView.tag == 1){//排序方式
        if ([_sort integerValue] == [self.pullView.selectedArray[0] integerValue]) {
            return;
        }
        _sort = [NSString stringWithFormat:@"%@",self.pullView.selectedArray[0]];
    }else{//科目二科目三
        if ([_kind integerValue] == [self.pullView.selectedArray[0] integerValue]) {
            return;
        }
        _kind = [NSString stringWithFormat:@"%@",self.pullView.selectedArray[0]];
    }
    [_btns[_whichBtnClicked] setTitle:title forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNearViewControlerReloadTable object:nil];
}

-(NSMutableArray *)btns{
    if (!_btns.count) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_btnWidth*i, 0, _btnWidth, self.frame.size.height)];
            btn.tag = i;
            btn.titleLabel.font = kFontOfLetterMedium;
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            if (i==0) {
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
            }

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
            if (sender.tag == 0) {//地区
                if ([_addr isEqualToString:[title substringFromIndex:2]]) {
                    return;
                }
                _addr = [title substringFromIndex:2];
                
            }else if(sender.tag == 1){//排序方式
                if ([_sort integerValue] == [self.pullView.selectedArray[0] integerValue]) {
                    return;
                }
                _sort = [NSString stringWithFormat:@"%@",self.pullView.selectedArray[0]];
            }else{//科目二科目三
                if ([_kind integerValue] == [self.pullView.selectedArray[0] integerValue]) {
                    return;
                }
                _kind = [NSString stringWithFormat:@"%@",self.pullView.selectedArray[0]];
            }
            [sender setTitle:title forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNearViewControlerReloadTable object:nil];
        }
    }
   
}
-(YRPullListView *)pullView{
    if (!_pullViews||_pullViews.count == 0) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            YRPullListView *pullView = [[YRPullListView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight/4) itemArray:_itemArrs[i]];
            pullView.tag = i;
            [_pullViews addObject:pullView];
        }
    }
    return _pullViews[_whichBtnClicked];
        
}
@end
