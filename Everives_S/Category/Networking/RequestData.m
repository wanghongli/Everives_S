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
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络无连接的提示
            [MBProgressHUD showError:@"无网络连接" toView:GET_WINDOW];
            return ;
        }
    }];
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
            NSDictionary *dic = [operation.responseData mj_JSONObject];
            if ([dic[@"info"] length]>0) {
                NSLog(@"%@",dic[@"info"]);
                if ([dic[@"info"] containsString:@"身份验证失败"]) {
                    return ;
                }
                [MBProgressHUD showError:dic[@"info"] toView:GET_WINDOW];
            }
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters complete:(void (^)(NSDictionary *))complete failed:(void (^)(NSError *))failed
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络无连接的提示
            [MBProgressHUD showError:@"无网络连接" toView:GET_WINDOW];
            return ;
        }
    }];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
    }
    MyLog(@"parameters - %@",parameters);
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    [manager POST:URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(complete){
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MyLog(@"%@",[operation.responseData mj_JSONString]);
        MyLog(@"operation - %@",operation);
        MyLog(@"error:%@",error);
        MyLog(@"code:%ld",(long)error.code);
        if (failed) {
            failed(error);
            NSDictionary *dic = [operation.responseData mj_JSONObject];
            if ([dic[@"info"] length]>0) {
                if ([dic[@"info"] containsString:@"身份验证失败"]) {
                    return ;
                }
                [MBProgressHUD showError:dic[@"info"] toView:GET_WINDOW];
            }
        }
    }];
}
+ (void)PUT:(NSString *)URLString
 parameters:(nullable id)parameters
   complete:(void (^)(NSDictionary *responseDic))complete
     failed:(void (^)(NSError *error))failed
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络无连接的提示
            [MBProgressHUD showError:@"无网络连接" toView:GET_WINDOW];
            return ;
        }
    }];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
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
            NSDictionary *dic = [operation.responseData mj_JSONObject];
            if ([dic[@"info"] length]>0) {
                if ([dic[@"info"] containsString:@"身份验证失败"]) {
                    return ;
                }
                [MBProgressHUD showError:dic[@"info"] toView:GET_WINDOW];
            }

        }
    }];
}
+(void)DELETE:(NSString *)URLString parameters:(id)parameters complete:(void (^)(NSDictionary *))complete failed:(void (^)(NSError *))failed
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络无连接的提示
            [MBProgressHUD showError:@"无网络连接" toView:GET_WINDOW];
            return ;
        }
    }];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
        //        NSLog(@"")
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URLString];
    [manager DELETE:URL parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(complete){
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",[operation.responseData mj_JSONString]);
        NSLog(@"error:%@",error);
        NSLog(@"code:%ld",(long)error.code);
        if (failed) {
            failed(error);
            NSDictionary *dic = [operation.responseData mj_JSONObject];
            if ([dic[@"info"] length]>0) {
                if ([dic[@"info"] containsString:@"身份验证失败"]) {
                    return ;
                }
                [MBProgressHUD showError:dic[@"info"] toView:GET_WINDOW];
            }

        }
    }];
}

#pragma mark - 获取题库
+ (void)GETQuestionBank:(NSString *)URIString
               complete:(void (^)(NSDictionary *responseDic))complete
                 failed:(void (^)(NSError *error))failed
{
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //网络无连接的提示
            [MBProgressHUD showError:@"无网络连接" toView:GET_WINDOW];
            return ;
        }
    }];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (KUserManager.id) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",KUserManager.id] forHTTPHeaderField:@"uid"];
        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:@"0" forHTTPHeaderField:@"kind"];
    }
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL_GET_QUESTION,URIString];
    [manager GET:URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if(complete){
            complete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",[operation.responseData mj_JSONString]);
        NSLog(@"error:%@",error);
        NSLog(@"code:%ld",(long)error.code);
        if (failed) {
            failed(error);
            NSDictionary *dic = [operation.responseData mj_JSONObject];
            [MBProgressHUD showError:dic[@"info"] toView:GET_WINDOW];

        }
    }];
}
@end
