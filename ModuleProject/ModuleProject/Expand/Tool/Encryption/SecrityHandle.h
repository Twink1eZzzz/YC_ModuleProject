//
//  SecrityHandle.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecrityHandle : NSObject
// md5 对字符串进行加密
+ (NSString *) md5WithString:(NSString *)sourceString;

// md5 对NSData类型进行进行加密
+ (NSString *)md5WithSourceData:(NSData *)sourceData;

// base64加密
+ (NSString *)base64EncodingWithSourceData:(NSData *)data;

// base64 解密
+ (NSData *)base64DecodingWithString:(NSString *)string;
@end
