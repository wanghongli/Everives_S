//
//  ReqestData.h
//  GoFishing
//
//  Created by darkclouds on 15/11/16.
//  Copyright © 2015年 darkclouds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking/AfNetworking.h"
#import "Http.h"

@interface RequestData : NSObject
+(void)requestInfomationWithURI:(NSString *)URI
                    andParameters:(id)theParameters
                         complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed;

+(void)requestInfomationContainUserMsgWithURI:(NSString *)URI
                  andParameters:(id)theParameters
                       complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed;
+(void)requestGetInfomationWithURI:(NSString *)URI
                                andParameters:(id)theParameters
                                     complete:(void (^)(NSDictionary *responseDic))complete failed:(void (^)(NSError *error))failed;
@end
