//
//  YROrderedPlaceModel.h
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YROrderedPlaceModel : NSObject
/**
 
 "id": "5",
 "date": "2016-03-26",
 "time": "2",
 "price": "200",
 "status": "4",'0未支付 1已支付，等待同伴一起拼 2已支付，等待去练车 3待评价 4已评价 5已取消'
 "kind": "0",'0科目2 1科目3'
 "pname": "测试",  #场地名称
 "tname": "Small",  #教练昵称
 "avatar": "https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1097386906,836054839&fm=58"
 */
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *kind;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *pname;
@property(nonatomic,strong) NSString *tname;
@property(nonatomic,strong) NSString *avatar;
@property(nonatomic,strong) NSString *more;
@end
