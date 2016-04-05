//
//  YROrderedPlaceDetailModel.h
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YRReservationModel;
@interface YROrderedPlaceDetailModel : NSObject<MJKeyValue>
/**
 *  {
 "id": "5",
 "uid": "1",
 "tid": "1",
 "info":
 [
 {
 "date": "2016-03-26",
 "time": 2,
 "index": "2016-03-262",
 "place": "测试",
 }
 ],
 "price": "200",
 "status": "4",
 "kind": "0",
 "time": "1458816184",
 "tname": "Small",
 "avatar": "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1097386906,836054839&fm=58",
 }
 */
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *tid;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *pname;
@property(nonatomic,strong) NSString *tname;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSArray *info;

@end
