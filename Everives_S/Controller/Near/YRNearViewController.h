//
//  YRNearViewController.h
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRNearViewController : UIViewController
/**
 *  是否继续学车，为yes直接跳转到教练列表
 */
@property(nonatomic,assign) BOOL isGoOnLearning;
/**
 *  是否是合拼教练，影响最终的订单生成
 */
@property(nonatomic,assign) BOOL isShareOrder;

/**
 *  合拼教练的同伴
 */
@property(nonatomic,strong) YRUserStatus *partnerModel;
@end