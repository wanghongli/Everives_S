//
//  YRCanOrderPlacesModel
//  Everives_S
//
//  Created by darkclouds on 16/3/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRCanOrderPlacesModel : NSObject
/**
 *  "date": "2016-03-27",
 "time": "2",
 "place":
 [
 "1",
 "2"
 ],
 "price": 200,
 */
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSArray *place;
@property(nonatomic,strong) NSString *price;
@end
