//
//  YRGroupModel.h
//  Everives_S
//
//  Created by darkclouds on 16/3/31.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRGroupModel : NSObject
/**
 *   "id": "1",
 "name": "魂守创建的群",
 "avatar": "http://pic.wenwen.soso.com/p/20120810/20120810140351-1462639986.jpg",
 "owner": "stu1",
 */
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *owner;
@end
