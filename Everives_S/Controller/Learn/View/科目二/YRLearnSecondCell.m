//
//  YRLearnSecondCell.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnSecondCell.h"
#import "UIImageView+WebCache.h"

@implementation YRLearnSecondCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self buildUI];
        
    }
    return self;
}

#pragma mark - 创建视图
-(void)buildUI
{
   
}
-(void)setTestNum:(NSInteger)testNum
{
    [self setCornerRadiusWith:self.firstImg];
    [self setCornerRadiusWith:self.leftImg];
    [self setCornerRadiusWith:self.rightImg];
    
    if (testNum%2) {
        self.leftImg.hidden = YES;
        self.rightImg.hidden = YES;
        self.changeImg.hidden = YES;
    }else{
        self.changeImg.hidden = NO;
        self.leftImg.hidden = NO;
        self.rightImg.hidden = NO;
    }
}
-(void)setTimeString:(NSString *)timeString
{
    _timeString = timeString;
    CGSize timeSize = [timeString sizeWithFont:self.timeLabel.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.frame = CGRectMake(self.timeLabel.x, self.timeLabel.y, timeSize.width+10, self.timeLabel.height);
    [self setCornerRadiusWith:self.timeLabel];
}


-(void)setCornerRadiusWith:(UIView *)corView
{
    corView.layer.masksToBounds = YES;
    corView.layer.cornerRadius = corView.height/2;
    corView.layer.borderWidth = 1;
    corView.layer.borderColor = kCOLOR(203, 204, 205).CGColor;
}
-(void)setTeacherOrder:(YRTeacherOrder *)teacherOrder
{
    _teacherOrder = teacherOrder;
    self.nameLabel.text = KUserManager.name;
    self.calendarLabel.text = teacherOrder.date;
    self.timeLabel.text = teacherOrder.time;
    self.addressLabel.text = teacherOrder.pname;
    [self.firstImg sd_setImageWithURL:[NSURL URLWithString:teacherOrder.avatar] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    
    [self setImgWith:1];
}
-(void)setImgWith:(NSInteger)testNum
{
    [self setCornerRadiusWith:self.firstImg];
    [self setCornerRadiusWith:self.leftImg];
    [self setCornerRadiusWith:self.rightImg];
    
    if (testNum%2) {
        self.leftImg.hidden = YES;
        self.rightImg.hidden = YES;
        self.changeImg.hidden = YES;
    }else{
        self.changeImg.hidden = NO;
        self.leftImg.hidden = NO;
        self.rightImg.hidden = NO;
    }
}
@end
