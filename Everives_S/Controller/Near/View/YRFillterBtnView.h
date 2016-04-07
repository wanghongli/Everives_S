//
//  YRFillterBtnView.h
//  Everives_S
//
//  Created by darkclouds on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
//这个类就是地区排序方式那一行

@interface YRFillterBtnView : UIView
@property(nonatomic,strong) NSArray *itemArrs;
@property(nonatomic,strong) NSString *addr;//返回选择后的地址
@property(nonatomic,assign) NSString *sort;//返回选择后的排序方式
@property(nonatomic,strong) NSString *kind;//0科目2 1科目3
@property(nonatomic,assign) BOOL hasObserver;
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titles;
-(void) addMyObserver;
-(void) removeMyObserver;
@end
