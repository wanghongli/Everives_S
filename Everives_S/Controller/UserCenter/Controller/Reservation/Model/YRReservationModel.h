//
//  YRReservationModel.h
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRReservationModel : NSObject
/**
 *  {
 "date": "2016-03-26",
 "time": 2,
 "index": "2016-03-262",//不用管
 "place": "测试",
 }
 */
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *place;
@property(nonatomic,strong) NSString *price;
@end
