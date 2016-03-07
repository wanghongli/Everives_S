//
//  ReqestData.m
//  GoFishing
//
//  Created by darkclouds on 15/11/16.
//  Copyright © 2015年 darkclouds. All rights reserved.
//

#import "RequestData.h"
#import "MJExtension.h"
@interface RequestData()
@end
@implementation RequestData

+ (void)GET:(NSString *)URIString
 parameters:(nullable id)parameters
   complete:(void (^)(NSDictionary *responseDic))complete
     failed:(void (^)(NSError *error))failed
{
    NSString *URLString = [NSString stringWithFormat:@"%@%@",SERVER_URL,URIString];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误信息描述
        NSLog(@"error - %@",[error.userInfo[@"com.alamofire.serialization.response.error.data"] mj_JSONString]);
        //错误编码
        NSLog(@"errorCode - %ld",(long)error.code);
        if (failed) {
            failed(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters complete:(void (^)(NSDictionary *))complete failed:(void (^)(NSError *))failed
{
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    [manger POST:UrlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complete) {
            complete(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误信息描述
        NSLog(@"error - %@",error);
        NSLog(@"error userinfo - %@",[error.userInfo[@"com.alamofire.serialization.response.error.data"] mj_JSONString]);
        //错误编码
        NSLog(@"errorCode - %ld",(long)error.code);
        if (failed) {
            failed(error);
        }
    }];
}

@end
