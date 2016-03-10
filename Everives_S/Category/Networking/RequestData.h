//
//  ReqestData.h
//  GoFishing
//
//  Created by darkclouds on 15/11/16.
//  Copyright © 2015年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AfNetworking.h>
#import "http.h"

@interface RequestData : NSObject
#pragma clang diagnostic ignored "-Wnullability-completeness"


+ (void)GET:(NSString *)URIString
 parameters:(nullable id)parameters
   complete:(void (^)(NSDictionary *responseDic))complete
     failed:(void (^)(NSError *error))failed;


+ (void)POST:(NSString *)URLString
                parameters:(nullable id)parameters
                complete:(void (^)(NSDictionary *responseDic))complete
                failed:(void (^)(NSError *error))failed;

+ (void)PUT:(NSString *)URLString
  parameters:(nullable id)parameters
    complete:(void (^)(NSDictionary *responseDic))complete
      failed:(void (^)(NSError *error))failed;
+ (void)DELETE:(NSString *)URLString
 parameters:(nullable id)parameters
   complete:(void (^)(NSDictionary *responseDic))complete
     failed:(void (^)(NSError *error))failed;

@end
