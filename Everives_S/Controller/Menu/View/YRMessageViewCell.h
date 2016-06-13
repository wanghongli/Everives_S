//
//  YRMessageViewCell.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YRMessageObject.h"
#import "YRMyFriendsObject.h"
@interface YRMessageViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *refuseBtn;
@property (weak, nonatomic) IBOutlet UIButton *acceptBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)btnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) YRMessageObject *messageObj;
@property (nonatomic, strong) void (^friendsStautsChange)(BOOL isSuccess);

@end
