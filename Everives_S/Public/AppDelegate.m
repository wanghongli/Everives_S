//
//  AppDelegate.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/2/17.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "AppDelegate.h"
#import "YRYJNavigationController.h"
#import "YRYJLearnToDriveController.h"
#import "YRYJMenuViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <MAMapKit/MAMapKit.h>
#import "RequestData.h"
#import "YRUserStatus.h"
#import "YRUserStatus.h"
@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //高德地图
    [MAMapServices sharedServices].apiKey = @"89bb4d69d45261a2a125e558dbf3ebb6";
    //融云即时通讯
    [[RCIM sharedRCIM] initWithAppKey:@"z3v5yqkbvtd30"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    
    NSDictionary* dicUser = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"user"];
    if (dicUser) {
        YRUserStatus*status = [YRUserStatus mj_objectWithKeyValues:dicUser];
        KUserManager = status;
        //连接融云服务器
        [[RCIM sharedRCIM] connectWithToken:KUserManager.rongToken success:^(NSString *userId) {
            // Connect 成功
        } error:^(RCConnectErrorCode status) {
        }
                             tokenIncorrect:^() {
                             }];
    }
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:[[YRYJLearnToDriveController alloc] init]];
    YRYJMenuViewController *menuController = [[YRYJMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    //
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    // Make it a root controller
    //
    self.window.rootViewController = frostedViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
/**
 * 融云推送处理
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
    //如果注册成功，可以删掉这个方法
    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
}
//融云即时通讯  头像昵称等个人信息
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{
    NSString *strID = @"";
    if ([userId hasPrefix:@"stu"]) {
        strID = [userId substringFromIndex:3];
    }
    [RequestData GET:[USER_INFO_BYID stringByAppendingString:strID] parameters:nil complete:^(NSDictionary *responseDic) {
        YRUserStatus *user = [YRUserStatus mj_objectWithKeyValues:responseDic];
        RCUserInfo *rcUser = [[RCUserInfo alloc]init];
        rcUser.userId = userId;
        rcUser.name = user.name;
        rcUser.portraitUri = user.avatar;
        return completion(rcUser);
    } failed:^(NSError *error) {
        
    } ];
    return completion(nil);
    
}
//融云即时通讯  群组信息
-(void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    [RequestData GET:[NSString stringWithFormat:@"%@/%@",GROUP_GROUP,groupId] parameters:nil complete:^(NSDictionary *responseDic) {
        if (responseDic.count>0) {
            RCGroup *group= [[RCGroup alloc] init];
            group.groupId = responseDic[@"id"];
            group.groupName = responseDic[@"name"];
            group.portraitUri = responseDic[@"avatar"];
            return completion(group);
        }
        
    } failed:^(NSError *error) {
    }];
    return completion(nil);
}
@end
