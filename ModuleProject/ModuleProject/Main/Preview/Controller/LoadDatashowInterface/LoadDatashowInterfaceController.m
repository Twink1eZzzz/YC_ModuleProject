//
//  LoadDatashowInterfaceController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/9.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "LoadDatashowInterfaceController.h"
#import "FeEqualize.h"


@interface LoadDatashowInterfaceController ()

@property (strong, nonatomic) FeEqualize *equalizer;

@end

@implementation LoadDatashowInterfaceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"加载数据是显示的占位页面";
    self.view.backgroundColor = MainColor;
    _equalizer = [[FeEqualize alloc] initWithView:self.view title:@"LOADING"];
    [self.view addSubview:_equalizer];
    [_equalizer show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_equalizer dismiss];
    });
}

- (UIColor *)set_colorBackground {
    return [UIColor whiteColor];
}



@end
