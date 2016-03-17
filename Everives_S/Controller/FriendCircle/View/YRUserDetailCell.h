//
//  YRUserDetailCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRUserDetailCell : UITableViewCell
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *descriString;

+(CGFloat)userDetailCellGetHeightWith:(NSString *)descriString;
@end
