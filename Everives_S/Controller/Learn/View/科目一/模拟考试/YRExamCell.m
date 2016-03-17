//
//  YRExamCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamCell.h"
@interface YRExamCell ()
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIView *centerView;
@property (nonatomic, weak) UILabel *menuLabel;
@property (nonatomic, weak) UILabel *msgLabel;
@end
@implementation YRExamCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    UIView *backview = [[UIView alloc]init];
    [self addSubview:backview];
    _backView = backview;
    
    UIView *centerview = [[UIView alloc]init];
    [self addSubview:centerview];
    _centerView = centerview;
    
    UILabel *menulabel = [[UILabel alloc]init];
    menulabel.textAlignment = NSTextAlignmentCenter;
    menulabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:menulabel];
    _menuLabel = menulabel;
    
    UILabel *msglabel = [[UILabel alloc]init];
    msglabel.textAlignment = NSTextAlignmentLeft;
    msglabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:msglabel];
    _msgLabel = msglabel;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}
- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
