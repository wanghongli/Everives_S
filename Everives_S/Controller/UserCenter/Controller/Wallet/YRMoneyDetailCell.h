//
//  YRMoneyDetailCell.h
//  Everives_S
//
//  Created by darkclouds on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YRMoneyDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
-(void)configCellWithContent:(NSString*)content time:(NSString*)time;
@end
