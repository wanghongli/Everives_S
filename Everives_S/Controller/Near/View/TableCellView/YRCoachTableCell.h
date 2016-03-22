//
//  YRCoachTableCell.h
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRCoachModel;
@interface YRCoachTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *teachAge;
@property (weak, nonatomic) IBOutlet UILabel *stuNum;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@property (weak, nonatomic) IBOutlet UILabel *course;

@property(nonatomic,strong) YRCoachModel *model;

@end
