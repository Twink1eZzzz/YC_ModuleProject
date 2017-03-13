//
//  SDPayViewController.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/3/10.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "SDPayViewController.h"
#import "SDPaymentTool.h"

@interface SDPayViewController ()

@end

@implementation SDPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)AlipayAction:(id)sender {
    [[SDPaymentTool sharedSDPaymentTool] AliPayWithMoney:@"200" ProductName:@"商品" ProductDesc:@"测试商品" OrderNumber:@"123456"];
}



- (IBAction)WechatPayAction:(id)sender {
    [[SDPaymentTool sharedSDPaymentTool] WechatPayWithMoney:@"200" OrderName:@"测试商品" OrderNumber:@"123456"];
}

@end
