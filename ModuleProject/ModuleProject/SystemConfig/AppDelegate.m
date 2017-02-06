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


#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import "WXApi.h"


@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 网络配置
    [[NetworkTool sharedNetworkTool] setupConfigWithServer:BASEURL Header:nil Parameters:nil];

    // window初始化
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    [YC_PlusButton registerPlusButton];
    YCTabBarControllerConfig *tabBarControllerConfig = [[YCTabBarControllerConfig alloc]init];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    
    /**
     * 根据需求加广告页
     */
    [self setupYCLaunchAd];
    
    [_window makeKeyAndVisible];
    
    [self init3rdParty];

    //引导页面加载
    [self setupIntroductoryPage];
    
    return YES;
}

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
    [WXApi registerApp:APP_KEY_WEIXIN];
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:APP_KEY_WEIBO];
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
   if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
    }
    
    return NO;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if([[url absoluteString] hasPrefix:@"wb"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:self];
        
    }else{
        return NO;
    }
}

#pragma mark - 实现代理回调
/**
 *  微博 (微博如果不做分享结果处理会出错)
 *
 *  @param response 响应体。根据 WeiboSDKResponseStatusCode 作对应的处理.
 *  具体参见 `WeiboSDKResponseStatusCode` 枚举.
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSString *message;
    switch (response.statusCode) {
        case WeiboSDKResponseStatusCodeSuccess:
            message = @"分享成功";
            break;
        case WeiboSDKResponseStatusCodeUserCancel:
            message = @"取消分享";
            break;
        case WeiboSDKResponseStatusCodeSentFail:
            message = @"分享失败";
            break;
        default:
            message = @"分享失败";
            break;
    }
    showAlert(message);
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
