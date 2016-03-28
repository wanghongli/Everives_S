//
//  YRSettingCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRSettingCell : UITableViewCell

@property (nonatomic, assign) BOOL swithHidden;
@property (nonatomic, assign) BOOL swithStatus;
@property (nonatomic, strong) void (^swithcIsOn)(BOOL switchClick);

@end
