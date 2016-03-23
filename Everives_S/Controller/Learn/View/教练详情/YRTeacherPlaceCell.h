//
//  YRTeacherPlaceCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRTeacherPlaceCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void) teacherPlaceGetSchoolName:(NSString *)schoolName address:(NSString *)address;

@end
