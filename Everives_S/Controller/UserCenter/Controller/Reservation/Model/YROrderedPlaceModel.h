//
//  YROrderedPlaceModel.h
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YROrderPartnerModel.h"
@interface YROrderedPlaceModel : NSObject

/*
{
    avatar = "http://7xr6ql.com1.z0.glb.clouddn.com/5017d44beba896b738db157a9179c967.jpg";
    date = "2016-04-23";
    id = 4;
    kind = 0;
    more = 1;
    partner =         {
        avatar = "http://7xr6ql.com1.z0.glb.clouddn.com/9d156c902e017ae388aacc3712e86a46.jpg";
        id = 12;
        name = "\U738b\U4e8c\U72d7";
    };
    pname = "\U5a01\U901a\U9a7e\U6821\U8bad\U7ec3\U573a";
    price = 200;
    status = 2;
    time = 1;
    tname = king;
}*/

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
@property(nonatomic,strong) YROrderPartnerModel *partner;

@end
