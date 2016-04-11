//
//  YRReservationChoosePlaceVC.h
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRTeacherDetailObj;
@interface YRReservationChoosePlaceVC : UITableViewController
@property(nonatomic,strong) NSArray *timeArray;
@property(nonatomic,strong) YRTeacherDetailObj *coachModel;
@end
