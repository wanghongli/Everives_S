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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URIString];
    [manager GET:URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(complete){
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",[operation.responseData mj_JSONString]);
        NSLog(@"error:%@",error);
        NSLog(@"code:%ld",(long)error.code);
        if (failed) {
            failed(error);
        }
    }];

}

+ (void)POST:(NSString *)URLString parameters:(id)parameters complete:(void (^)(NSDictionary *))complete failed:(void (^)(NSError *))failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
//        NSLog(@"")
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(complete){
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[operation.responseData mj_JSONString]);
        NSLog(@"error:%@",error);
        NSLog(@"code:%ld",(long)error.code);
        if (failed) {
            failed(error);
        }
    }];
}
+ (void)PUT:(NSString *)URLString
 parameters:(nullable id)parameters
   complete:(void (^)(NSDictionary *responseDic))complete
     failed:(void (^)(NSError *error))failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
        //        NSLog(@"")
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    [manager PUT:URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(complete){
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",[operation.responseData mj_JSONString]);
        NSLog(@"error:%@",error);
        NSLog(@"code:%ld",(long)error.code);
        if (failed) {
            failed(error);
        }
    }];
}
@end
