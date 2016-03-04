//
//  ReqestData.m
//  GoFishing
//
//  Created by darkclouds on 15/11/16.
//  Copyright © 2015年 darkclouds. All rights reserved.
//

#import "RequestData.h"
@interface RequestData()
@end
@implementation RequestData
+(void)GET:(NSString *)URIString parameters:(id)parameters progress:(void (^)(NSProgress *))downloadProgress success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    NSString *URLString = [NSString stringWithFormat:@"%@%@",SERVER_URL,URIString];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}

+(void)POST:(NSString *)URIString parameters:(id)parameters progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(NSURLSessionDataTask *, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure{
    NSString *URLString = [NSString stringWithFormat:@"%@%@",SERVER_URL,URIString];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];
}

@end
