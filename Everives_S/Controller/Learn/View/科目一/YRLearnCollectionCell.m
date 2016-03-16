//
//  YRLearnCollectionCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/15.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnCollectionCell.h"
@interface YRLearnCollectionCell ()
@property (nonatomic, strong) UITableView *tableview;
@end
@implementation YRLearnCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_tableview];
        
    }
    return self;
}

@end
