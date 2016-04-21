//
//  YRSettingPrivacyCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/29.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSettingPrivacyCell.h"

#define kDistace 20

@interface YRSettingPrivacyCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UIView *centerView;

@end
@implementation YRSettingPrivacyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self buildUI];
        
    }
    return self;
}

-(void)buildUI
{
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.font = kFontOfLetterBig;
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titlelabel];
    _titleLabel = titlelabel;
    
    UIView *backview = [[UIView alloc]init];
    [self addSubview:backview];
    _backView = backview;
    
    UIView *centerview = [[UIView alloc]init];
    centerview.backgroundColor = [UIColor lightGrayColor];
    [_backView addSubview:centerview];
    _centerView = centerview;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _backView.frame = CGRectMake(kScreenWidth - kDistace - kDistace, self.height/2-kDistace/2, kDistace, kDistace);
    _centerView.frame = CGRectMake(kDistace/2-kDistace/4, kDistace/2-kDistace/4, kDistace/2, kDistace/2);
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = _backView.height/2;
    _backView.layer.borderWidth = 1;
    if (_selectBool) {
        _backView.layer.borderColor = kCOLOR(53, 117, 173).CGColor;
        _centerView.backgroundColor = kCOLOR(53, 117, 173);
    }else{
        _backView.layer.borderColor = kCOLOR(220, 220, 220).CGColor;
        _centerView.backgroundColor = [UIColor lightGrayColor];
    }
    
    _centerView.layer.masksToBounds = YES;
    _centerView.layer.cornerRadius = _centerView.height/2;
    
    _titleLabel.frame = CGRectMake(kDistace, 0, kScreenWidth-4*kDistace, self.height);
    
    
}
-(void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    _titleLabel.text = titleString;
}
-(void)setSelectBool:(BOOL)selectBool
{
    _selectBool = selectBool;
}
@end
