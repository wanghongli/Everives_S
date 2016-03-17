//
//  YRSchoolModel.m
//  Everives_S
//
//  Created by darkclouds on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSchoolModel.h"
#import "YRPictureModel.h"
@implementation YRSchoolModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"pics":[YRPictureModel class]};
}
@end
