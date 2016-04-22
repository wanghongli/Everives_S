//
//  YRActivityModel.h
//  Everives_S
//
//  Created by darkclouds on 16/4/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YRActivityModel : NSObject
/**
 *   "id": "1",
 "title": "注册有礼",
 "intro": "注册即送200学车币哦！",
 "pic": "http://pic.qqtn.com/up/2016-4/2016042113490413110.jpg",
 "begintime": "2012-12-21",
 "endtime": "2099-01-01",
 "detail": "",
 */
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *intro;
@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *begintime;
@property(nonatomic,strong) NSString *endtime;
@property(nonatomic,strong) NSString *detail;
@end
