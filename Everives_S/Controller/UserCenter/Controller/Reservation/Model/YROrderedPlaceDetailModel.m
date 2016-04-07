//
//  YROrderedPlaceDetailModel.m
//  Everives_S
//
//  Created by darkclouds on 16/4/1.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YROrderedPlaceDetailModel.h"
#import "YRReservationModel.h"
@implementation YROrderedPlaceDetailModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"info":[YRReservationModel class]};
}
@end
