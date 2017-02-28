//
//  LoadDatashowInterfaceController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/9.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "LoadDatashowInterfaceController.h"
#import "JHUD+WaitView.h"


@interface LoadDatashowInterfaceController ()

@end

@implementation LoadDatashowInterfaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"加载数据是显示的占位页面";
    self.view.backgroundColor = [UIColor whiteColor];
    [JHUD showCircleAnimation];
    
//    [JHUD showCustomAnimationWithImagePrefixName:@"loading_" FirstIndex:1 LastIndex:8 Msg:nil];
}

- (UIColor *)set_colorBackground {
    return [UIColor whiteColor];
}

- (UIButton *)set_rightButton {
    UIButton *left_button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [left_button setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateNormal];
    [left_button setImage:[UIImage imageNamed:@"nav_complete"] forState:UIControlStateHighlighted];
    return left_button;
}

- (void)right_button_event:(UIButton *)sender
{
    [JHUD hideView];
}


@end
