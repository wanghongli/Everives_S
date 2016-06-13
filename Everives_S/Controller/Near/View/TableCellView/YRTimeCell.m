//
//  YRTimeCell.m
//  Everives_T
//
//  Created by darkclouds on 16/5/5.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTimeCell.h"
static NSInteger rowNum = 7; //横着的那种
#define kdateHeight 50
#define kcellHeight ((kScreenHeight-64-kdateHeight)/rowNum)
#define kcellWidth 62.5

@implementation YRTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _startTime = [[UILabel alloc] initWithFrame:CGRectMake(0, kcellHeight/2-20, kcellWidth, 20)];
        _startTime.font = kFontOfLetterMedium;
        _startTime.textAlignment = NSTextAlignmentCenter;
        _startTime.textColor = kYRBlackTextColor;
        _endTime = [[UILabel alloc] initWithFrame:CGRectMake(0, kcellHeight/2, kcellWidth, 20)];
        _endTime.font = kFontOfLetterMedium;
        _endTime.textAlignment = NSTextAlignmentCenter;
        _endTime.textColor = kYRBlackTextColor;
        _centerL = [[UILabel alloc] initWithFrame:CGRectMake(0, kcellHeight/2-2, kcellWidth, 4)];
        _centerL.font = kFontOfLetterMedium;
        _centerL.text = @"-";
        _centerL.textAlignment = NSTextAlignmentCenter;
        _centerL.textColor = kYRBlackTextColor;
        [self.contentView addSubview:_startTime];
        [self.contentView addSubview:_endTime];
        [self.contentView addSubview:_centerL];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
    }
    return self;
}
-(void)configCellWithStratTime:(NSString *)start endTime:(NSString *)end{
    _startTime.text = start;
    _endTime.text = end;
}
@end
