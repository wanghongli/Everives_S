//
//  YRTeacherDetailObj.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/6.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherDetailObj.h"

@implementation YRTeacherDetailObj
+ (NSDictionary *)objectClassInArray
{
    return @{@"pics":[YRTeacherPicsObj class],@"place":[YRTeacherPlaceObj class],@"comment":[YRTeacherCommentObj class]};
}
@end
