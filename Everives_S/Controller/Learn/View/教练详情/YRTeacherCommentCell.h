//
//  YRTeacherCommentCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTeacherCommentObj.h"
@interface YRTeacherCommentCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) YRTeacherCommentObj *teacherCommentObj;

+ (CGFloat) getTeacherCommentCellHeightWith:(NSString *)introduce;
@end
