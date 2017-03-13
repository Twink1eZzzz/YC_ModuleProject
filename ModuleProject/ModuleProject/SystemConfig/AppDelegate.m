//
//  AppDelegate.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/5.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "AppDelegate.h"
#import "YCTabBarControllerConfig.h"
#import "introductoryPagesHelper.h"
#import "YC_PlusButton.h"
#import "ThirdMacros.h"
#import "AppDelegate+YCLaunchAd.h"
#import "LBXAlertAction.h"
#import "JDStatusBarNotification.h"

// QQ、微博、微信分享
#import "GSPlatformParamConfigManager.h"
#import "GSSocialManager.h"

// 引 JPush功能所需头 件
#import "JPUSHService.h"
// iOS10注册APNs所需头 件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

// 支付宝
#import <AlipaySDK/AlipaySDK.h>

// 微信
#import "WXApi.h"

static NSString *appKey = @"AppKey copied from JPush Portal application";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate ()<JPUSHRegisterDelegate,WXApiDelegate>

@property (strong, nonatomic) NSDictionary *userInfo;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // window初始化
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    [YC_PlusButton registerPlusButton];
    YCTabBarControllerConfig *tabBarControllerConfig = [[YCTabBarControllerConfig alloc]init];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    [_window makeKeyAndVisible];
    
    // 极光推送初始化
    [self registerJPush:launchOptions];
    
    // 网络配置
    [[NetworkTool sharedNetworkTool] setupConfigWithServer:BASEURL Header:nil Parameters:nil];
    
    // Core Data 初始化
    [MagicalRecord setupCoreDataStack];
    
    // 根据需求加广告页
    [self setupYCLaunchAd];
    
    // 第三方分享注册
    [self init3rdParty];

    //引导页面加载
    [self setupIntroductoryPage];
    
    return YES;
}

/*******************************************************************************************************************************************************************************/

#pragma mark 引导页
-(void)setupIntroductoryPage
{
    if ([kUserDefaults objectForKey:@"isNoFirstLaunch"]) {
        return;
    }
    [kUserDefaults setBool:YES forKey:@"isNoFirstLaunch"];
    [kUserDefaults synchronize];
    NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"];
    [introductoryPagesHelper showIntroductoryPageView:images];
}

/**
 *  初始化第三方组件
 */
- (void)init3rdParty
{
    [[GSPlatformParamConfigManager share] addSinaPlatformConfigAppKey:APP_KEY_WEIBO redirectURI:APP_KEY_WEIBO_RedirectURL];
    [[GSPlatformParamConfigManager share] addQQPlatformConfigAppID:APP_KEY_QQ];
    [[GSPlatformParamConfigManager share] addWeChatPlatformConfigAppID:APP_KEY_WEIXIN secret:@""];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    YCLog(@"%@",url);
    
    BOOL res = [[GSSocialManager share] handleOpenURL:url];
    if (!res) {
        //做其他SDK回调处理
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                YCLog(@"result = %@",resultDic);
            }];
        }
    }
    return res;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    YCLog(@"%@",url);
    
    BOOL res = [[GSSocialManager share] handleOpenURL:url];
    if (!res) {
        //做其他SDK回调处理
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                YCLog(@"result = %@",resultDic);
            }];
        }
    }
    return res;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    YCLog(@"%@",url);
    
    BOOL res = [[GSSocialManager share] handleOpenURL:url];
    if (!res) {
        //做其他SDK回调处理
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                YCLog(@"result = %@",resultDic);
            }];
        }
    }
    return res;
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        showAlert(strMsg);
    }
}

/*******************************************************************************************************************************************************************************/

#pragma mark - 极光推送初始化
- (void)registerJPush:(NSDictionary *)launchOptions
{
    // Required
    // notice: 3.0.0及以后版本注册可以这样写，也可以继续 旧的注册 式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert | JPAuthorizationOptionBadge | JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            YCLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            YCLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}

/*******************************************************************************************************************************************************************************/

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

/********************************************************************JPUSH***************************************************************************************************/

// 注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

// 实现注册APNs失败接口 (可选)
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    YCLog(@"实现注册APNs失败接口和失败原因: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    YCLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    if (application.applicationState == UIApplicationStateActive) {
        //程序运行时收到通知，先弹出消息框
        
        [self getPushMessageAtStateActive:userInfo];
        
    } else{
        //程序已经关闭或者在后台运行
        [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        
    }
    
    [application setApplicationIconBadgeNumber:0];
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max

// 前台收到通知
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            [self getPushMessageAtStateActive:userInfo];
        } else {
            [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        }
    } else {
        // 判断为本地通知
        YCLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

// 后台收到推送
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        YCLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
            [self getPushMessageAtStateActive:userInfo];
        } else {
            [self pushToViewControllerWhenClickPushMessageWith:userInfo];
        }
        
    } else {
        // 判断为本地通知
        YCLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}

#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    return str;
}


#pragma mark -- 程序运行时收到通知
-(void)getPushMessageAtStateActive:(NSDictionary *)pushMessageDic{
    [LBXAlertAction showAlertWithTitle:@"推送提示" msg:[[pushMessageDic objectForKey:@"aps"]objectForKey:@"alert"] buttonsStatement:@[@"立即前往",@"稍后"] chooseBlock:^(NSInteger buttonIdx) {
        YCLog(@"%ld",buttonIdx);
        if (buttonIdx == 0) {
            [self pushToViewControllerWhenClickPushMessageWith:pushMessageDic];
        }
    }];
    
}

#pragma mark - 跳转指定页面处理
// 根据项目具体设置
-(void)pushToViewControllerWhenClickPushMessageWith:(NSDictionary*)msgDic{
    
    
//    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
//    
//    if ([[msgDic objectForKey:@"pageType"] integerValue]==0){
//        
//        //      跳转到第一个tabbarItem，这时直接设置 UITabBarController的selectedIndex属性就可以
//        
//        self.tabController.selectedIndex = 0;
//        
//    }else if ([[msgDic objectForKey:@"pageType"] integerValue]==1){
//        
//        //跳转到第二个tabbarItem
//        
//        self.tabController.selectedIndex = 1;
//        
//        
//    }else if ([[msgDic objectForKey:@"pageType"] integerValue]==2){
//        //跳转到第三个tabbarItem
//        
//        
//        self.tabController.selectedIndex = 2;
//        
//    }else if ([[msgDic objectForKey:@"pageType"] integerValue]==3){
//        //详情，这是从跳转到第一个tabbarItem跳转过去的，所以我们可以先让tabController.selectedIndex =0;然后找到VC的nav。
//        
//        self.tabController.selectedIndex =0;
//        DetailViewController * VC = [[DetailViewController alloc]init];
//        [VC setHidesBottomBarWhenPushed:YES];
//        //因为我用了三方全屏侧滑手势，所以要找的是第一个tabbarController中的viewController的JTNavigationController ，接着再找JTNavigationController 里面的jt_viewControllers.lastObject，这样就可以找到FirstViewController了，然后跳转的时候就和正常的跳转一样了
//        JTNavigationController *nav=(JTNavigationController *)self.tabController.viewControllers[0];
//        UIViewController *vc=(UIViewController*)nav.jt_viewControllers.lastObject;
//        
//        [vc.navigationController pushViewController:VC animated:NO];
//        
//    }else {
//        
//    }
    
}


@end
