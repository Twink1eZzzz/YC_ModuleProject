//
//  YCTabBarControllerConfig.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/5.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "YCTabBarControllerConfig.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "TestViewController.h"
#import "Test2ViewController.h"
#import "KLTNavigationController.h"

@interface YCTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation YCTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController
{
    if (_tabBarController == nil) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    HomeViewController *firstViewController = [[HomeViewController alloc] init];
    KLTNavigationController *firstNavigationController = [[KLTNavigationController alloc]initWithRootViewController:firstViewController];
    
    
    TestViewController *secondViewController = [[TestViewController alloc]init];
    KLTNavigationController *secondNavigationController = [[KLTNavigationController alloc]initWithRootViewController:secondViewController];
    
    Test2ViewController *thirdViewController = [[Test2ViewController alloc]init];
    KLTNavigationController *thirdNavigationController = [[KLTNavigationController alloc]initWithRootViewController:thirdViewController];
    
    MeViewController *fourthViewController = [[MeViewController alloc] init];
    KLTNavigationController *fourthNavigationController = [[KLTNavigationController alloc] initWithRootViewController:fourthViewController];

    NSArray *viewControllers = @[firstNavigationController,secondNavigationController,thirdNavigationController,fourthNavigationController];

    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
            CYLTabBarItemTitle : @"首页",
            CYLTabBarItemImage : @"home_normal",
            CYLTabBarItemSelectedImage : @"home_highlight",
    };
    NSDictionary *secondTabBarItemsAttributes = @{
            CYLTabBarItemTitle : @"同城",
            CYLTabBarItemImage : @"mycity_normal",
            CYLTabBarItemSelectedImage : @"mycity_highlight",
    };
    NSDictionary *thirdTabBarItemsAttributes = @{
            CYLTabBarItemTitle : @"示例演示",
            CYLTabBarItemImage : @"message_normal",
            CYLTabBarItemSelectedImage : @"message_highlight",
    };
    NSDictionary *fourthTabBarItemsAttributes = @{
            CYLTabBarItemTitle : @"我的",
            CYLTabBarItemImage : @"account_normal",
            CYLTabBarItemSelectedImage : @"account_highlight"
    };
    NSArray *tabBarItemsAttributes = @[
            firstTabBarItemsAttributes,
            secondTabBarItemsAttributes,
            thirdTabBarItemsAttributes,
            fourthTabBarItemsAttributes
    ];
    return tabBarItemsAttributes;
}

#pragma mark - TabBarAppearance
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // 自定义 TabBar 高度
    tabBarController.tabBarHeight = 44.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
//     [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
//     [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
