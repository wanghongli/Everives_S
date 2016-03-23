//
//  YRTeacherDetailCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRTeacherDetailCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) NSString *introduce;

+ (CGFloat) getTeacherDetailCellHeightWith:(NSString *)introduce;
@end
