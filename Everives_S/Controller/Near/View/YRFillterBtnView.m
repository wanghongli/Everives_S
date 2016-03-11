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
    NSArray *_itemArrs;
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
        _btnNum = _titles.count;
        _btnWidth = frame.size.width/_btnNum;
        for (NSInteger i = 0; i<_btnNum; i++) {
            [self addSubview:self.btns[i]];
        }
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        _itemArrs = @[@[@"重庆",@"上海",@"北京"],@[@"南岸",@"江北",@"渝北",@"渝中"]];
    }
    return self;
}
-(NSMutableArray *)btns{
    if (!_btns.count) {
        for (NSInteger i = 0; i<_titles.count; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(_btnWidth*i, 0, _btnWidth, self.frame.size.height)];
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
    if (ishiden) {
        ishiden = NO;
        [self.superview addSubview:self.pullView];
    }else{
        NSInteger num1 = [_pullView.selectedArray[0] integerValue];
        NSInteger num2 = [_pullView.selectedArray[1] integerValue];
        if (num1!=-1&&num2!=-1) {
            NSString *title = [NSString stringWithFormat:@"%@/%@",_itemArrs[0][num1],_itemArrs[1][num2]];
            [sender setTitle:title forState:UIControlStateNormal];
        }
        ishiden = YES;
        [self.pullView removeFromSuperview];
    }
   
}
-(YRPullListView *)pullView{
    if (!_pullView) {
        _pullView = [[YRPullListView alloc] initWithFrame:CGRectMake(0, 45, kScreenWidth, kScreenHeight/4) itemArray:_itemArrs];
    }
    return _pullView;
}
@end
