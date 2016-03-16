//
//  YRFriendCircleCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
typedef enum {
    
    ICON_CLICK = 0,   // 头像被点击
    ZAN_CLICK, //赞被点击
    MSG_CLICK       //消息被点击
    
} YRFriendCircleType;
#import <UIKit/UIKit.h>
@class YRCircleCellViewModel;
@interface YRFriendCircleCell : UITableViewCell
@property (nonatomic, strong) YRCircleCellViewModel *statusF;
@property (nonatomic, assign) BOOL lineBool;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) void (^commentOrAttentClickBlock)(NSInteger comOrAtt);
@property (nonatomic, strong) void (^iconClickBlock)(BOOL userBool);
@end
