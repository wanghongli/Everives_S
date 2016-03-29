//
//  YRMoneyDetailCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMoneyDetailCell.h"
#import "NSString+Tools.h"

@implementation YRMoneyDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configCellWithContent:(NSString *)content time:(NSString *)time{
    _contentLabel.text = content;
    NSString *timeStr =[NSString dateStringWithInterval:time];
    _timeLabel.text = timeStr;
}
@end
