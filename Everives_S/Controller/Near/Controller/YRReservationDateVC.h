//
//  YRReservationDateVC.h
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRTeacherDetailObj;
@interface YRReservationDateVC : UIViewController
@property(nonatomic,strong) YRTeacherDetailObj *coachModel;
@property(nonatomic,assign) BOOL isShareOrder;
/**
 *  合拼教练的同伴
 */
@property(nonatomic,strong) YRUserStatus *partnerModel;
@end
