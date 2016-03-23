//
//  YRLearnSecondCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/21.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRLearnSecondCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UILabel *calendarLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;

@property (nonatomic, assign) NSInteger testNum;
@property (nonatomic, strong) NSString *timeString;
@end
