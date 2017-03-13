//
//  SDPaymentTool.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/3/9.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "SDPaymentTool.h"

@implementation SDPaymentTool
YCSingletonM(SDPaymentTool);


/**
 *  支付宝支付
 */
- (void)AliPayWithMoney:(NSString *)money ProductName:(NSString*)name ProductDesc:(NSString*)productDesc OrderNumber:(NSString *)orderNumber
{
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = KALIAPPID;
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    NSString *rsa2PrivateKey = KRSA2PRIVATEKEY;
    
    if ([appID length] == 0 || [rsa2PrivateKey length] == 0) {
        showAlert(@"缺少appId或者私钥");
        return;
    }
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = @"RSA2";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.total_amount = money; //商品价格
    order.biz_content.body = productDesc; // 详情
    order.biz_content.subject = name; // 标题
    order.biz_content.out_trade_no = orderNumber; //订单ID（由商家自行制定)
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:rsa2PrivateKey];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            self.successBlock(@"");
        }];
    }
    
}

/**
 *  微信支付
 */
- (void)WechatPayWithMoney:(NSString *)money OrderName:(NSString*)ordername OrderNumber:(NSString *)orderNumber
{
    if ([WXApi isWXAppInstalled] == NO) { [MBProgressHUD showInfoMessage:@"微信客户端未安装"]; return;}
    if ([WXApi isWXAppSupportApi] == NO) { [MBProgressHUD showInfoMessage:@"微信客户端版本不支持"]; return;}
    
    {
        // 创建支付签名对象
        payRequsestHandler *req = [[payRequsestHandler alloc]init];
        // 初始化支付签名对象
        [req init:WECHATAPPID mch_id:MERCHANTNUMBERID];
        // 设置密钥
        [req setKey:WECHATPRIVATEKEY];
        
        // 订单编号 （商家自定义服务器返回）
        NSString *orderNumberStr = orderNumber;
        
        // 订单标题 （展示给用户看）
        NSString *orderNameStr = ordername;
        
        // 价格 (微信是<分>为单位)
        float orderPrice = [money floatValue] *100;
        NSString *finalPrice = [NSString stringWithFormat:@"%.0f",orderPrice];
        
        //================================
        //预付单参数订单设置
        //================================
        NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
        [packageParams setObject:orderNumberStr forKey:@"orderNum"];
        [packageParams setObject:orderNameStr forKey:@"auctionName"];
        [packageParams setObject:finalPrice forKey:@"paymentPrice"];
        NSDictionary *wechatDic = [req sendPay:packageParams];
        
        if (wechatDic == nil) {
            NSString *Debug = [req getDebugifo];
            [MBProgressHUD showErrorMessage:Debug];
        }else {
            NSMutableString *stamp  = [wechatDic objectForKey:@"timestamp"];
            //调起微信支付
            PayReq *reqs             = [[PayReq alloc] init];
            reqs.openID              = [wechatDic objectForKey:@"appid"];
            reqs.partnerId           = [wechatDic objectForKey:@"partnerid"];
            reqs.prepayId            = [wechatDic objectForKey:@"prepayid"];
            reqs.nonceStr            = [wechatDic objectForKey:@"noncestr"];
            reqs.timeStamp           = stamp.intValue;
            reqs.package             = [wechatDic objectForKey:@"package"];
            reqs.sign                = [wechatDic objectForKey:@"sign"];
            [WXApi sendReq:reqs];
        }
        
    }
    
}


/**
 *  支付成功时候的回调
 */
-(void)paySuccessWithBlock:(RequestSuccessAndResponseStringBlock)payBlock
{
    self.successBlock = payBlock;
}


@end
