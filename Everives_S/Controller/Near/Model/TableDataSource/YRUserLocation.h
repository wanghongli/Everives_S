//
//  YRUserLocation.h
//  Everives_S
//
//  Created by darkclouds on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRUserLocation : NSObject
//保存实时定位信息
@property(nonatomic,strong) NSString *addr;
@property(nonatomic,strong) NSString *latitude;
@property(nonatomic,strong) NSString *longitude;
@end
