//
//  YRWeibo.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRWeibo.h"
#import "YRCircleComment.h"
@implementation YRWeibo
+ (NSDictionary *)objectClassInArray
{
    return @{@"comment":[YRCircleComment class]};
}
@end
