//
//  YRFillterBtnView.h
//  Everives_S
//
//  Created by darkclouds on 16/3/11.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRFillterBtnView : UIView
@property(nonatomic,strong) NSArray *itemArrs;
-(instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray*)titles;
@end
