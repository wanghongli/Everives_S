//
//  YRReservationCell.h
//  Everives_S
//
//  Created by darkclouds on 16/3/4.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YROrderedPlaceModel;
@interface YRReservationCell : UITableViewCell
-(void)configCellWithModel:(YROrderedPlaceModel*)model;
@end
