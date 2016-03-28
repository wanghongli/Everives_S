//
//  YRMoneyDetailModel.h
//  Everives_S
//
//  Created by darkclouds on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRMoneyDetailModel : NSObject
/**
 *   "id": "1",
 "uid": "1",
 "content": "充值100元",
 "num": "100",
 "time": "9999",
 */
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *num;
@property(nonatomic,strong) NSString *time;
@end
