//
//  YRMapSelectView.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMapSelectView.h"
@interface YRMapSelectView()

@end
@implementation YRMapSelectView
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 64, kScreenWidth, 44);
        [self addSubview:self.schoolBtn];
        [self addSubview:self.coachBtn];
        [self addSubview:self.studentBtn];
        [self addSubview:self.lineView];
        _selectedBtnNum = 1;
    }
    return self;
}
-(UIButton *)schoolBtn{
    if (!_schoolBtn) {
        _schoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-150, 0, 60, 44)];
        [_schoolBtn setTitle:@"驾校" forState:UIControlStateNormal];
        [_schoolBtn addTarget:self action:@selector(schoolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_schoolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _schoolBtn;
}
-(UIButton *)coachBtn{
    if (!_coachBtn) {
        _coachBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, 0, 60, 44)];
        [_coachBtn setTitle:@"教练" forState:UIControlStateNormal];
        [_coachBtn addTarget:self action:@selector(coachBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_coachBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _coachBtn;
}
-(UIButton *)studentBtn{
    if (!_studentBtn) {
        _studentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2+90, 0, 60, 44)];
        [_studentBtn setTitle:@"驾友" forState:UIControlStateNormal];
        [_studentBtn addTarget:self action:@selector(studentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_studentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _studentBtn;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-160, 44, 80, 1.5)];
        _lineView.backgroundColor = [UIColor redColor];
    }
    return _lineView;
}
-(void)schoolBtnClick:(UIButton*)sender{
    [UIView animateWithDuration:0.4 animations:^{
        _lineView.frame = CGRectMake(kScreenWidth/2-160, 44, 80, 1.5);
    }];
    _selectedBtnNum = 1;
    [self.delegate schoolBtnClick:sender];
}
-(void)coachBtnClick:(UIButton*)sender{
    [UIView animateWithDuration:0.4 animations:^{
        _lineView.frame = CGRectMake(kScreenWidth/2-40, 44, 80, 1.5);
    }];
    _selectedBtnNum = 2;
    [self.delegate coachBtnClick:sender];
}
-(void)studentBtnClick:(UIButton*)sender{
    [UIView animateWithDuration:0.4 animations:^{
        _lineView.frame = CGRectMake(kScreenWidth/2+80, 44, 80, 1.5);
    }];
    _selectedBtnNum = 3;
    [self.delegate studentBtnClick:sender];
}
@end
