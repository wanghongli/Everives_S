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
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
#import "SDWebImageManager.h"
#import "YRQuestionObj.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMessage.h"

//友盟推送
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //高德地图
    [MAMapServices sharedServices].apiKey = @"89bb4d69d45261a2a125e558dbf3ebb6";
    
    //友盟分享
    [UMSocialData setAppKey:kUMengAppkey];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kSinaAppkey secret:kSinaAppSecret RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:kAppID appKey:kTencentAppkey url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:kWeChatID appSecret:kWeChatSecret url:@"http://www.umeng.com/social"];
    
    //友盟推送
    [UMessage startWithAppkey:@"5705eecf67e58e8850000269" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    
    //融云即时通讯
    [[RCIM sharedRCIM] initWithAppKey:@"z3v5yqkbvtd30"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    
    //短信验证码注册
    [SMSSDK registerApp:appkey
             withSecret:app_secrect];
    [SMSSDK enableAppContactFriends:NO];//不访问通讯录

    //获取登陆信息
    [self loginClick];
    
    /**
     * 融云推送处理1
     */
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
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

#pragma mark - 获取登陆信息
-(void)loginClick
{
    NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
    NSDictionary *dicUser = [userDefaults objectForKey:@"user"];
    if (!dicUser) {
        return;
    }
    YRUserStatus *user = [YRUserStatus mj_objectWithKeyValues:dicUser];
    KUserManager = user;
    //连接融云服务器
    [[RCIM sharedRCIM] connectWithToken:KUserManager.rongToken success:^(NSString *userId) {
        // Connect 成功
        MyLog(@"融云链接成功");
    }
                                  error:^(RCConnectErrorCode status) {
                                      MyLog(@"error_status = %ld",status);
                                  }
                         tokenIncorrect:^() {
                             MyLog(@"token incorrect");
                         }];
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
#pragma mark - 当内存警告时SDWebimage清除换成
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止下载图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 清除内存缓存图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}


//融云推送处理2  注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}
/**
 * 融云推送处理3   友盟推送处理
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
    [UMessage registerDeviceToken:deviceToken];
    
}

/**
 * 融云推送处理4  友盟推送
 */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /**
     * 统计推送打开率2
     */
    [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    /**
     * 获取融云推送服务扩展字段2
     */
    NSDictionary *pushServiceData = [[RCIMClient sharedRCIMClient] getPushExtraFromRemoteNotification:userInfo];
    if (pushServiceData) {
        NSLog(@"该远程推送包含来自融云的推送服务");
        for (id key in [pushServiceData allKeys]) {
            NSLog(@"key = %@, value = %@", key, pushServiceData[key]);
        }
    } else {
        NSLog(@"该远程推送不包含来自融云的推送服务");
    }
    
    [UMessage didReceiveRemoteNotification:userInfo];
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

//SSO登陆
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
@end
