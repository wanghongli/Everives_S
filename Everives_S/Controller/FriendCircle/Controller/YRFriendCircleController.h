//
//  YRFriendCircleController.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRUserStatus.h"
@interface YRFriendCircleController : UITableViewController
@property (nonatomic, strong) YRUserStatus *userStatus;

@property (nonatomic, strong) NSString *refreshMsg;
@end
