//
//  YROrderConfirmViewController.h
//  Everives_S
//
//  Created by darkclouds on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRTeacherDetailObj;
@interface YROrderConfirmViewController : UITableViewController
@property(nonatomic,strong) NSDictionary *parameters;//提交订单的参数
@property(nonatomic,strong) NSArray *DateTimeArray;
@property(nonatomic,strong) YRTeacherDetailObj *coachModel;
@end
