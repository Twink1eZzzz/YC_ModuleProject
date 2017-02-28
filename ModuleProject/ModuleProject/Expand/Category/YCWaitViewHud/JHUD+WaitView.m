//
//  JHUD+WaitView.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/23.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "JHUD+WaitView.h"

@implementation JHUD (WaitView)

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }
    return superVC;
}

+ (instancetype)createJHUD {
    JHUD *hudView = [[JHUD alloc]initWithFrame:[self getCurrentUIVC].view.bounds];
    return hudView;
}

+ (void)showCustomAnimationWithImagePrefixName:(NSString *)imageprefixname FirstIndex:(int)firstindex LastIndex:(int)lastIndex Msg:(NSString *)msg {
    NSMutableArray * images = [NSMutableArray array];
    for (int index = firstindex; index< lastIndex; index++) {
        NSString * imageName = [NSString stringWithFormat:@"%@%d.png",imageprefixname,index];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    JHUD *hudView = [self createJHUD];
    hudView.indicatorViewSize = CGSizeMake(110, 10);
    hudView.customAnimationImages = images;
    hudView.messageLabel.text = msg;
    [hudView showAtView:[self getCurrentUIVC].view hudType:JHUDLoadingTypeCustomAnimations];
}

+ (void)showCircleAnimation {
    JHUD *hudView = [self createJHUD];
    hudView.indicatorBackGroundColor = [UIColor whiteColor];
    hudView.indicatorForegroundColor = [UIColor lightGrayColor];
    [hudView showAtView:[self getCurrentUIVC].view hudType:JHUDLoadingTypeCircle];
}

+ (void)hideView {
    [self hideForView:[self getCurrentUIVC].view];
}

@end
