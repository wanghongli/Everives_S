//
//  YRCoachModel.h
//  Everives_S
//
//  Created by darkclouds on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface YRCoachModel : MAPointAnnotation

/**
 *   "id": "1",
 "name": "Small",
 "avatar": "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1097386906,836054839&fm=58",
 "grade": "3.0",
 "year": "0",
 "student": "0",
 "kind": "0",
 "lat": "29.614683",
 "lng": "106.498465",
 "distance": 11596932,
 */
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *grade;
@property(nonatomic,strong) NSString *year;
@property(nonatomic,strong) NSString *student;
@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *lat;
@property(nonatomic,strong) NSString *lng;
@property(nonatomic,strong) NSString *distance;
@end
