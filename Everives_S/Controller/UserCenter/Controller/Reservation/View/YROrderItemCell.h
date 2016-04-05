//
//  YROrderItemCell.h
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YRReservationModel;
@interface YROrderItemCell : UITableViewCell
-(void)configCellWithModel:(YRReservationModel*)model;
@end
