//
//  YRMessageObject.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MJExtension.h"

@interface YRMessageObject : NSObject
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) NSInteger link;//标示其他ID
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger uid;
@end
