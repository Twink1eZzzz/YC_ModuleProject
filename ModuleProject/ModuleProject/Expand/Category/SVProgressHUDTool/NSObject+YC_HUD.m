//
//  NSObject+YC_HUD.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/6.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "NSObject+YC_HUD.h"
#import "YC_ProgressHUD.h"

@implementation NSObject (YC_HUD)

- (void)showText:(NSString *)aText
{
    [YC_ProgressHUD showWithStatus:aText];
}


- (void)showErrorText:(NSString *)aText
{
    [YC_ProgressHUD showErrorWithStatus:aText];
}

- (void)showSuccessText:(NSString *)aText
{
    [YC_ProgressHUD showSuccessWithStatus:aText];
}

- (void)showLoading
{
    [YC_ProgressHUD show];
}


- (void)dismissLoading
{
    [YC_ProgressHUD dismiss];
}

- (void)showProgress:(NSInteger)progress
{
    [YC_ProgressHUD showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
}

- (void)showImage:(UIImage*)image text:(NSString*)aText
{
    [YC_ProgressHUD showImage:image status:aText];
}

@end
