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
        for (NSInteger i = 0; i<_btnNum; i++) {
            [self addSubview:self.btns[i]];
        }
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        _itemArrs = @[@[@[@"重庆",@"上海",@"北京"],@[@"南岸",@"江北",@"渝北",@"渝中",@"北碚",@"巴南",@"沙坪坝"]],
                        @[@[@"人气最高",@"长得最帅",@"评分最高"]]];
    }
    return self;
}
-(NSMutableArray *)btns{
    if (!_btns.count) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_btnWidth*i, 0, _btnWidth, self.frame.size.height)];
            btn.tag = i;
            [btn setTitle:_titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [_btns addObject:btn];
        }
    } 
    return _btns;
}
//显示、隐藏下拉列表
-(void)btnClick:(UIButton*)sender{
    static BOOL ishiden = YES;
    //-1表示没有选择
    if (_whichBtnClicked != -1 && _whichBtnClicked != sender.tag) {
        [self.pullView removeFromSuperview];
        ishiden = YES;
    }
    _whichBtnClicked = sender.tag;
    if (ishiden) {
        ishiden = NO;
        [self.superview addSubview:self.pullView];
    }else{
        ishiden = YES;
        if (![self.pullView.selectedArray containsObject:@-1]) {
            NSString *title = [NSString string];
            for (NSInteger i =0; i<self.pullView.selectedArray.count; i++) {
                title = [title stringByAppendingString:_itemArrs[_whichBtnClicked][i][[self.pullView.selectedArray[i] integerValue]]];
            }
            [sender setTitle:title forState:UIControlStateNormal];
        }
        [self.pullView removeFromSuperview];
    }
   
}
-(YRPullListView *)pullView{
    if (!_pullView) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            YRPullListView *pullView = [[YRPullListView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight/4) itemArray:_itemArrs[i]];
            [_pullViews addObject:pullView];
        }
    }
    return _pullViews[_whichBtnClicked];
        
}
@end
