//
//  YRTeacherCommentDownView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/13.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTeacherCommentDetailObj.h"
@interface YRTeacherCommentDownView : UIView
@property (nonatomic, strong) YRTeacherCommentDetailObj *detailObj;

+ (CGFloat)getTeacherCommentDownViewObj:(YRTeacherCommentDetailObj *)detailObj;
@end
