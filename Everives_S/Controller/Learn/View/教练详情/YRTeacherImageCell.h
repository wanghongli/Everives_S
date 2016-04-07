//
//  YRTeacherImageCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRTeacherPicsObj.h"
@interface YRTeacherImageCell : UITableViewCell

@property (nonatomic, strong) NSArray *imgArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
