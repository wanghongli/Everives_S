//
//  YRCircleCommentCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRCircleComment;
@interface YRCircleCommentCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)detailCommentCellWith:(NSArray*)commentArray;

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, strong) void (^userNameTapClickBlock)(YRCircleComment *user);

@end
