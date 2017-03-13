//
//  SDPaymentTool.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/3/9.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCSingleton.h"

// AlipayHeader
#import "Order.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


// WechatPayHeader
#import "WXApi.h"
#import "payRequsestHandler.h"


// UnionPayHeader


/************************************************************相关参数**************************************************************************************************/

                                 /**********************支付宝相关参数**************************************/

// NOTE: 支付宝分配给开发者的应用ID(如2014072300007148)
#define KALIAPPID @""

// NOTE: 私钥
// rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
#define KRSA2PRIVATEKEY @""

// NOTE: (非必填项)支付宝服务器主动通知商户服务器里指定的页面http路径
#define KNOTIFYURL @""


                                /**********************微信相关参数**************************************/

// NOTE: 微信APPID
#define WECHATAPPID @""

// NOTE: 商户号
#define MERCHANTNUMBERID @""

// NOTE: 商户密钥
#define WECHATPRIVATEKEY @""





typedef void(^RequestSuccessAndResponseStringBlock)(NSString *string);


@interface SDPaymentTool : NSObject
YCSingletonH(SDPaymentTool);

@property (nonatomic,copy) RequestSuccessAndResponseStringBlock successBlock;

/**
 *  支付宝支付
 */
- (void)AliPayWithMoney:(NSString *)money ProductName:(NSString*)name ProductDesc:(NSString*)productDesc OrderNumber:(NSString *)orderNumber;

/**
 *  微信支付
 */
- (void)WechatPayWithMoney:(NSString *)money OrderName:(NSString*)ordername OrderNumber:(NSString *)orderNumber;


/**
 *  支付成功时候的回调
 */
-(void)paySuccessWithBlock:(RequestSuccessAndResponseStringBlock)payBlock;

@end
