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
#import "SharedMapView.h"
#import "YRFriendViewController.h"
#import "YRMenuMessageController.h"
#import <Pingpp.h>

//友盟推送
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

@interface AppDelegate ()<RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMReceiveMessageDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [MAMapServices sharedServices].apiKey = kAMapAppKey;
    [AMapSearchServices sharedServices].apiKey = kAMapAppKey;
    [SharedMapView sharedInstance];
    //友盟分享
    [UMSocialData setAppKey:kUMengShareAppkey];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kSinaAppkey secret:kSinaAppSecret RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:kAppID appKey:kTencentAppkey url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:kWeChatID appSecret:kWeChatSecret url:@"http://www.umeng.com/social"];
    
    //友盟推送
    [UMessage startWithAppkey:kUMengAppKey launchOptions:launchOptions];
    
    //融云即时通讯
    [[RCIM sharedRCIM] initWithAppKey:kRCIMAppKey];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM] setGroupInfoDataSource:self];
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    
    //短信验证码注册
    [SMSSDK registerApp:kSMSSDKappkey
             withSecret:kSMSSDKappSecrect];
    [SMSSDK enableAppContactFriends:NO];//不访问通讯录

    
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
    //获取登陆信息
    [self login];
 
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:[[YRYJLearnToDriveController alloc] init]];
    YRYJMenuViewController *menuController = [[YRYJMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
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
-(void)login
{
    NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
    NSDictionary *dicUser = [userDefaults objectForKey:@"user"];
    if (!dicUser) {
        return;
    }
    NSDictionary *account = [userDefaults objectForKey:@"loginCount"];
    [RequestData POST:USER_LOGIN parameters:@{@"tel":account[@"tel"],@"password":[account objectForKey:@"psw"],@"kind":@"0",@"type":@"1"} complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        YRUserStatus *user = [YRUserStatus mj_objectWithKeyValues:responseDic];
        NSUserDefaults*userDefaults=[[NSUserDefaults alloc]init];
        [userDefaults setObject:responseDic forKey:@"user"];
        [NSUserDefaults resetStandardUserDefaults];
        KUserManager = user;
        [self connectRongCloud];
        [self registerUMessageRemoteNotification];

    } failed:^(NSError *error) {
    }];

}
-(void)connectRongCloud{
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
-(void)registerUMessageRemoteNotification{
    //友盟推送
    [UMessage setAlias:KUserManager.id type:@"STU" response:nil];
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
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //如果用户设置了不接受聊天消息推送，则断开与融云的连接
    if(!(KUserManager.push&2)){
        [[RCIM sharedRCIM]logout];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //如果用户设置了不接受聊天消息推送,回到前台需要继续使用融云则需要重新连接
    if(!(KUserManager.push&2)){
        [self connectRongCloud];
    }
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
    NSLog(@"deviceToken  %@",[deviceToken description]);
    //友盟
    [UMessage registerDeviceToken:deviceToken];
    //融云
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    
}

/**
 * 融云推送处理4  友盟推送
 */
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (userInfo[@"YR_TYPE"]) {//友盟推送
        [UMessage didReceiveRemoteNotification:userInfo];
        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        {
            //添加闹钟小红点
            [[NSNotificationCenter defaultCenter] postNotificationName:kReceivedUMengMessage object:nil];
            
        }else{
            YRMenuMessageController *messageVC = [[YRMenuMessageController alloc]init];
            YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:messageVC];
            ((REFrostedViewController*)(self.window.rootViewController)).contentViewController = navigationController;
        }
    }else{//融云推送
        /**
         * 统计推送打开率2
         */
        [[RCIMClient sharedRCIMClient] recordRemoteNotificationEvent:userInfo];
    }
}

-(void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification{
    //点击收到融云消息的推送
    YRFriendViewController *friendViewController = [[YRFriendViewController alloc] init];
    YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:friendViewController];
    ((REFrostedViewController*)self.window.rootViewController).contentViewController = navigationController ;
}
//SSO登陆
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用ping++
        BOOL canHandleURL = [Pingpp handleOpenURL:url withCompletion:nil];
        return canHandleURL;
    }
    return result;
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
#pragma mark - RCIMReceiveMessageDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    //收到融云消息
    [[NSNotificationCenter defaultCenter] postNotificationName:kReceivedRCIMMessage object:nil];
}
-(NSMutableDictionary *)circleCacheDic
{
    if (_circleCacheDic==nil) {
        _circleCacheDic = [NSMutableDictionary dictionary];
    }
    return _circleCacheDic;
}
@end
