//
//  YRTimeCell.h
//  Everives_T
//
//  Created by darkclouds on 16/5/5.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRTimeCell : UITableViewCell
@property(nonatomic,strong) UILabel *startTime;
@property(nonatomic,strong) UILabel *endTime;
@property(nonatomic,strong) UILabel *centerL;
-(void)configCellWithStratTime:(NSString*)start endTime:(NSString*)end;
@end
