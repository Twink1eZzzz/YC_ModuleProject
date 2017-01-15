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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 网络配置
    [[NetworkTool sharedNetworkTool] setupConfigWithServer:@"http://192.168.198.237:8080/biz-ws-deploy/" Header:nil Parameters:nil];

    // window初始化
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    YCTabBarControllerConfig *tabBarControllerConfig = [[YCTabBarControllerConfig alloc]init];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    [_window makeKeyAndVisible];

    //引导页面加载
    [self setupIntroductoryPage];

    /**
     * 根据需求加广告页
     */
    
    return YES;
}

#pragma mark 引导页
-(void)setupIntroductoryPage
{
    if ([USER objectForKey:@"isNoFirstLaunch"])
    {
        return;
    }
    [USER setBool:YES forKey:@"isNoFirstLaunch"];
    [USER synchronize];
    NSArray *images=@[@"introductoryPage1",@"introductoryPage2",@"introductoryPage3",@"introductoryPage4"];
    [introductoryPagesHelper showIntroductoryPageView:images];
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
