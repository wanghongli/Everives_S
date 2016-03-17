//
//  YRSchoolModel.h
//  Everives_S
//
//  Created by darkclouds on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+MJKeyValue.h>
@interface YRSchoolModel : NSObject<MJKeyValue>
/**
 *  "id": "1",
 "uid": "0",
 "school": "无",
 "name": "测试",
 "tel": "454",
 "intro": "好礼",
 "address": "重庆市渝北区黄杨路靠近凤凰座(B)",
 "addcode": "0",
 "lat": "29.613982",
 "lng": "106.499322",
 "grade": "0.0",
 "rank": "0",
 "pics":
 [
 {
 "intro": "哈哈",
 "url": "http://7xr6ql.com1.z0.glb.clouddn.com/u14581989361342031173982.jpg",
 }
 ],
 "admin": "4",
 "area": "0",
 "cfw": "0",
 "bpqb": "0",
 "zjzw": "0",
 "qxxs": "0",
 "dcrk": "0",
 */

@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *school;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *tel;
@property(nonatomic,strong) NSString *intro;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *addcode;
@property(nonatomic,strong) NSString *lat;
@property(nonatomic,strong) NSString *lng;
@property(nonatomic,strong) NSString *grade;
@property(nonatomic,strong) NSString *rank;
@property(nonatomic,strong) NSString *time;
@property(nonatomic,strong) NSArray *pics;
@property(nonatomic,strong) NSString *admin;
@property(nonatomic,strong) NSString *area;
@property(nonatomic,strong) NSString *cfw;
@property(nonatomic,strong) NSString *bpqb;
@property(nonatomic,strong) NSString *zjzw;
@property(nonatomic,strong) NSString *qxxs;
@property(nonatomic,strong) NSString *dcrk;
@end
