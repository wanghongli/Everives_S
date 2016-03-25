//
//  YRMyCoachVC.h
//  Everives_S
//
//  Created by darkclouds on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRMyCoachVC : UITableViewController
@property(nonatomic,assign) BOOL isAllowSelected;
@property(nonatomic,strong) NSMutableArray *selectedCoachIDArray;//返回选择的教练id数组
@property(nonatomic,strong) NSString *selectedCoachName;//如果只选择了一个教练则返回教练名字用于创建聊天
@end
