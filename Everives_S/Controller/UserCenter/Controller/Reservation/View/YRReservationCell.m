//
//  YRReservationCell.m
//  Everives_S
//
//  Created by darkclouds on 16/3/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRReservationCell.h"
#import "YROrderedPlaceModel.h"
#import <UIImageView+WebCache.h>
@interface YRReservationCell(){
    NSArray *_times;
    NSArray *_statusArr;
}

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UILabel *coach;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIImageView *course;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *weekday;

@end
@implementation YRReservationCell

- (void)awakeFromNib {
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.cornerRadius = 45;
    _time.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    _time.textColor = [UIColor whiteColor];
    _time.layer.cornerRadius = 10;
    _time.layer.masksToBounds = YES;
    _price.textColor = [UIColor colorWithRed:250/255.0 green:126/255.0 blue:48/255.0 alpha:1];
    _status.textColor = [UIColor colorWithRed:250/255.0 green:126/255.0 blue:48/255.0 alpha:1];
    _coach.textColor = [UIColor colorWithRed:118/255.0 green:119/255.0 blue:121/255.0 alpha:1];
    _times = @[@"09:00-10:00",@"10:00-11:00",@"11:00-12:00",@"14:00-15:00",@"15:00-16:00",@"16:00-17:00",@"17:00-18:00"];
    _statusArr = @[@"未支付" ,@"已支付",@"等待同伴一起拼",@"已支付",@"等待去练车", @"待评价" ,@"已评价" ,@"已取消"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configCellWithModel:(YROrderedPlaceModel *)model{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    NSString *datey = [model.date substringToIndex:4];
    NSString *datem = [model.date substringWithRange:NSMakeRange(5, 2)];
    NSString *dated = [model.date substringFromIndex:8];
    _date.text = [NSString stringWithFormat:@"%@年%@月%@日",datey,datem,dated];
    _time.text = _times[[model.time integerValue]];
    _place.text = model.pname;
    _coach.text= model.tname;
    _status.text = _statusArr[[model.status integerValue]];
    _course.image = [UIImage imageNamed:[model.kind isEqualToString:@"0"]?@"CoachInformation_Grade-2":@"CoachInformation_Grade-3"];
    _price.text = [NSString stringWithFormat:@"￥%@",model.price];
    _weekday.text = [NSString getTheDayInWeek:model.date];
}
@end