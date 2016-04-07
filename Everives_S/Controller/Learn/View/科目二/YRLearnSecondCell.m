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
    self.nameLabel.text = teacherOrder.tname;
    
    NSString *datey = [teacherOrder.date substringToIndex:4];
    NSString *datem = [teacherOrder.date substringWithRange:NSMakeRange(5, 2)];
    NSString *dated = [teacherOrder.date substringFromIndex:8];
    NSString *calendarString = [NSString stringWithFormat:@"%@年%@月%@日",datey,datem,dated];
    NSString *weekString = [NSString getTheDayInWeek:teacherOrder.date];
    self.calendarLabel.text = [NSString stringWithFormat:@"%@ %@",calendarString,weekString];
    
    NSArray *times = @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"];
    self.timeLabel.text = times[teacherOrder.time];;
    [self setCornerRadiusWith:self.timeLabel];

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
