//
//  YRShareOrderConfirmViewController.h
//  Everives_S
//
//  Created by darkclouds on 16/4/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRTeacherDetailObj;
@interface YRShareOrderConfirmViewController : UITableViewController
@property(nonatomic,strong) NSDictionary *parameters;//提交订单的参数
@property(nonatomic,strong) NSArray *DateTimeArray;
@property(nonatomic,strong) YRTeacherDetailObj *coachModel;
@property(nonatomic,assign) NSInteger totalPrice;
/**
 *  合拼教练的同伴
 */
@property(nonatomic,strong) YRUserStatus *partnerModel;
@end
