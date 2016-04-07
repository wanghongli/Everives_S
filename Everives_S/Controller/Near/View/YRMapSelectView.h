//
//  YRMapSelectView.h
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YRMapSelectViewDelegate<NSObject>
-(void)schoolBtnClick:(UIButton*)sender;
-(void)coachBtnClick:(UIButton*)sender;
-(void)studentBtnClick:(UIButton*)sender;
@end


@interface YRMapSelectView : UIView
@property(nonatomic,strong) UIButton *schoolBtn;
@property(nonatomic,strong) UIButton *coachBtn;
@property(nonatomic,strong) UIButton *studentBtn;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,weak) id<YRMapSelectViewDelegate> delegate;

@property(nonatomic,assign) NSInteger selectedBtnNum;//1、2、3分别表示  驾校 教练  驾友

-(instancetype)initWithSelectedNum:(NSInteger)num;
@end


