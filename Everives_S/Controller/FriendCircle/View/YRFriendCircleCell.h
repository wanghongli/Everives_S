//
//  YRFriendCircleCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRCircleCellViewModel;
@interface YRFriendCircleCell : UITableViewCell
@property (nonatomic, strong) YRCircleCellViewModel *statusF;
@property (nonatomic, assign) BOOL lineBool;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) void (^commentOrAttentClickBlock)(NSInteger comOrAtt);

@end
