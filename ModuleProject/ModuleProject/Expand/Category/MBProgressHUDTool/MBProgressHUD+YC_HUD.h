//
//  MBProgressHUD+YC_HUD.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/22.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YC_HUD)

// 只显示文字
+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;


// 显示指示器 + 文字
+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;

// 显示样式
+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;


// 自定义显示样式
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;

// 个性定制
+ (void)showPendulumWithMessage:(NSString *)message isWindow:(BOOL)iswindow;


+ (void)hideHUD;

@end
