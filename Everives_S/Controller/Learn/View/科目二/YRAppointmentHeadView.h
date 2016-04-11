//
//  YRAppointmentHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRAppointmentHeadViewDelegate <NSObject>

- (void)appointmentHeadViewClick;

@end
#import <UIKit/UIKit.h>
#import "YRLearnOrderDetail.h"
@interface YRAppointmentHeadView : UIView
@property (nonatomic, strong) YRLearnOrderDetail *orderDetail;

@property (nonatomic, assign) id<YRAppointmentHeadViewDelegate>delegate;
@end
