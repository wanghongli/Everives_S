//
//  YRCircleComment.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleComment.h"

@implementation YRCircleComment
+ (NSDictionary *)objectClassInArray
{
    return @{@"child":[YRCircleComment class]};
}
@end
