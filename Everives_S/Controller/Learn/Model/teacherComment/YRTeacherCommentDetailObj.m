//
//  YRTeacherCommentDetailObj.m
//  Everives_S
//
//  Created by 李洪攀 on 16/4/13.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRTeacherCommentDetailObj.h"
#import "YRLearnOrderDetailInfo.h"

@implementation YRTeacherCommentDetailObj
+ (NSDictionary *)objectClassInArray
{
    return @{@"info":[YRLearnOrderDetailInfo class]};
}
@end
