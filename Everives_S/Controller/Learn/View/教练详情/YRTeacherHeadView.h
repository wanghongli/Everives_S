//
//  YRTeacherHeadView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTeacherDetailObj.h"
@interface YRTeacherHeadView : UIImageView

@property (nonatomic, strong) YRTeacherDetailObj *teacherObj;
@property (nonatomic, strong) NSString *kind;
@end
