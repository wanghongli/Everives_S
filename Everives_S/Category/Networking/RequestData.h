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
                              progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

+ (void)POST:(NSString *)URIString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
@end
