//
//  ReqestData.m
//  GoFishing
//
//  Created by darkclouds on 15/11/16.
//  Copyright © 2015年 darkclouds. All rights reserved.
//

#import "RequestData.h"


@implementation RequestData
+(void)requestInfomationWithURI:(NSString *)URI andParameters:(id)theParameters complete:(void (^)(NSDictionary *))complete failed:(void (^)(NSError *))failed{
    
    AFHTTPSessionManager *serssionManager = [AFHTTPSessionManager manager];
    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URI];
    
    [serssionManager POST:URL parameters:theParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:URL parameters:theParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if(complete){
//            complete(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        MyLog(@"Error: %@", error);
//        if (failed) {
//            failed(error);
//        }
//    }];
}
//+(void)requestInfomationContainUserMsgWithURI:(NSString *)URI
//                                andParameters:(id)theParameters
//                                     complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed
//{
////    if (!KUserManager.netWorkBool) {
////        [MBProgressHUD showError:@"" toView:[[UIApplication sharedApplication].delegate window]];
////        return;
////    }
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    if (KUserManager.id) {
//        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)KUserManager.id] forHTTPHeaderField:@"uid"];
//        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
//    }
//    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URI];
//    [manager POST:URL parameters:theParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if(complete){
//            complete(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failed) {
//            failed(error);
//        }
//    }];
//}
//+(void)requestGetInfomationWithURI:(NSString *)URI
//                     andParameters:(id)theParameters
//                          complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    if (KUserManager.id) {
//        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",(long)KUserManager.id] forHTTPHeaderField:@"uid"];
//        [manager.requestSerializer setValue:KUserManager.token forHTTPHeaderField:@"token"];
//    }
//    NSString *URL = [NSString stringWithFormat:@"%@%@",SERVER_URL,URI];
//    [manager GET:URL parameters:theParameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        if(complete){
//            complete(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"Error: %@", error);
//        if (failed) {
//            failed(error);
//        }
//    }];
//}
@end
