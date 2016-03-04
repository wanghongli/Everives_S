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
@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //融云即时通讯
    [[RCIM sharedRCIM] initWithAppKey:@"z3v5yqkbvtd30"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    //连接融云服务器
    [[RCIM sharedRCIM] connectWithToken:@"kRongCloud_IM_User_Token" success:^(NSString *userId) {
        // Connect 成功
    }
    error:^(RCConnectErrorCode status) {
                                  }
                         tokenIncorrect:^() {
                         }];
    
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
//    NSDictionary *parameters = @{@"id":userId};
//    [RequestData requestInfomationWithURI:USER_GETUSERINFO andParameters:parameters complete:^(NSDictionary *responseDic) {
//        KGUserStatus*status = [KGUserStatus mj_objectWithKeyValues:responseDic];
//        KGUserLoginObject *user = status.data;
//        
//        RCUserInfo *rcUser = [[RCUserInfo alloc]init];
//        rcUser.userId = [NSString stringWithFormat:@"%li",user.id];
//        rcUser.name = user.name;
//        rcUser.portraitUri = user.avatar;
//        return completion(rcUser);
//    } failed:^(NSError *error) {
//        MyLog(@"获取用户信息失败");
//    }];
    return completion(nil);
    
}
//融云即时通讯  群组信息
-(void)getGroupInfoWithGroupId:(NSString *)groupId completion:(void (^)(RCGroup *))completion{
    
}
@end
