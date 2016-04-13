//
//  YRTeacherDetailController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//  教练详情

#import <UIKit/UIKit.h>

@interface YRTeacherDetailController : UIViewController
@property (nonatomic, strong) NSString *teacherID;
@property(nonatomic,strong) NSString *kind;
@property(nonatomic,assign) BOOL isShareOrder;
/**
 *  合拼教练的同伴
 */
@property(nonatomic,strong) YRUserStatus *partnerModel;
@end
