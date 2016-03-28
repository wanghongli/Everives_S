//
//  YRSettingCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSettingCell.h"
@interface YRSettingCell ()

@property (nonatomic, weak) UISwitch *switchView;

@end
@implementation YRSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    
    UISwitch *switchview = [[UISwitch alloc]init];
    [switchview addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:switchview];
    _switchView = switchview;
    
}

-(void)switchClick:(UISwitch *)sender
{
    if (self.swithcIsOn) {
        self.swithcIsOn(sender.isOn);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _switchView.frame = CGRectMake(0, 0, 51, 31);
    _switchView.center = CGPointMake(kScreenWidth-25-20, self.height/2);
    
}
-(void)setSwithHidden:(BOOL)swithHidden
{
    _swithHidden = swithHidden;
    _switchView.hidden = swithHidden;
}
-(void)setSwithStatus:(BOOL)swithStatus
{
    _swithStatus = swithStatus;
    _switchView.on = swithStatus;
}
@end
