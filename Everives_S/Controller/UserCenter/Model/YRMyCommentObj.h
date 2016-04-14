//
//  YRMyCommentObj.h
//  Everives_S
//
//  Created by 李洪攀 on 16/4/14.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface YRMyCommentObj : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger kind;
@property (nonatomic, strong) NSString *pname;
@property (nonatomic, strong) NSString *tname;
@end
