//
//  SecrityHandle.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "SecrityHandle.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation SecrityHandle
#pragma mark MD5 加密
// md5对字符串进行加密
+ (NSString *) md5WithString:(NSString *)sourceString{
    // 转化类型 NSString -> C 字符数组
    const char *str = sourceString.UTF8String;
    // C字符数组
    unsigned char result [CC_MD5_DIGEST_LENGTH];
    // 进行加密
    CC_MD5(str, (CC_LONG)strlen(str), result);
    // 转化类型 C -> NSString
    NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *item = [NSString stringWithFormat:@"%02X", result[i]];
        [resultString appendString:item];
    }
    return resultString;
}

// md5对NSData类型进行进行加密
+ (NSString *)md5WithSourceData:(NSData *)sourceData{
    // 声明并初始化 md5 变量
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    // 准备加密
    CC_MD5_Update(&md5, sourceData.bytes, (CC_LONG)sourceData.length);
    // 创建 char 数组接收加密之后的数组
    unsigned char result [CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(result, &md5);
    // char数组 --> NSString 的接收NSString类型对象
    NSMutableString *resultString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    // char数组 -> NSString
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *item = [NSString stringWithFormat:@"%02X", result[i]];
        [resultString appendString:item];
    }
    return resultString;
}

#pragma mark base64 加密 和 解密
// base64加密
+ (NSString *)base64EncodingWithSourceData:(NSData *)data{
    NSString *resultString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return resultString;
}

// base64 解密
+ (NSData *)base64DecodingWithString:(NSString *)string{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

@end
