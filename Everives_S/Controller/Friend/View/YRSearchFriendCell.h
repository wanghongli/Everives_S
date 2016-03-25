//
//  YRSearchFriendCell.h
//  Everives_S
//
//  Created by darkclouds on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRSearchFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
-(void) configureCellWithAvatar:(NSString*) avatar name:(NSString*)name;
@end
