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
@property (nonatomic, weak) UIImageView *showSelectedView;

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
    
    UIImageView *backview = [[UIImageView alloc]init];
    [self addSubview:backview];
    _showSelectedView = backview;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _showSelectedView.frame = CGRectMake(kScreenWidth - kDistace - kDistace, self.height/2-kDistace/2, kDistace, kDistace);
    _showSelectedView.layer.masksToBounds = YES;
    _showSelectedView.layer.cornerRadius = _showSelectedView.height/2;
    if (_selectBool) {
        _showSelectedView.image = [UIImage imageNamed:@"Pay_Selected"];
    }else{
        _showSelectedView.image = [UIImage imageNamed:@"Pay_NotSelected"];
    }
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
