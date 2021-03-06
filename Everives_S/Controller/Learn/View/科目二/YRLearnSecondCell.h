//
//  YRLearnSecondCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTeacherOrder.h"
@interface YRLearnSecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UILabel *calendarLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;
@property (weak, nonatomic) IBOutlet UIImageView *changeImg;

@property (nonatomic, assign) NSInteger testNum;
@property (nonatomic, strong) NSString *timeString;

@property (nonatomic, strong) YRTeacherOrder *teacherOrder;
@end
