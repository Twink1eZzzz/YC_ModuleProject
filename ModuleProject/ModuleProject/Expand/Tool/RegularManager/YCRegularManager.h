//
//  YCRegularManager.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/2/20.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCRegularManager : NSObject
/**
 *  邮箱验证
 */
+ (BOOL)yc_checkingEmail:(NSString *)email;

/**
 *  手机号验证
 */
+(BOOL)yc_checkingMobile:(NSString *)mobile;

/**
 *  电话号验证
 */
+(BOOL)yc_checkingPhoneNum:(NSString *)phoneNum;

/**
 *  身份证号验证(15位 或 18位)
 */
+(BOOL)yc_checkingIdCard:(NSString *)idCard;

/**
 *  密码验证
 *
 *  @param shortest 最短长度
 *  @param longest  最长长度
 *  @param pwd      密码
 *
 *  @return 结果
 */
+(BOOL)yc_checkingPasswordWithShortest:(NSInteger)shortest
                               longest:(NSInteger)longest
                              password:(NSString *)pwd;


/**
 *  由数字和26个英文字母组成的字符串
 *
 */
+ (BOOL)yc_checkingStrFormNumberAndLetter:(NSString *)data;

/**
 *  校验只能输入由26个小写英文字母组成的字符串
 */
+ (BOOL)yc_checkingStrFormLowerAndUpperLetter:(NSString *)data;


/**
 *  校验只能输入小写字母
 */
+ (BOOL)yc_checkingLowerLetter:(NSString *)lowerCase;

/**
 *  校验只能输入大写字母
 */
+ (BOOL)yc_checkingUpperLetter:(NSString *)upperCase;


/**
 *  是否含有特殊字符(%&’,;=?$\等)
 */
+ (BOOL)yc_checkingSpeciaychar:(NSString *)data;


/**
 *  校验只能输入数字
 */
+ (BOOL)yc_checkingNumber:(NSString *)number;

/**
 *  校验只能输入n位的数字
 *
 *  @param length n位
 *  @param number 数字
 */
+ (BOOL)yc_checkingNumberWithLength:(NSString *)length number:(NSString *)number;

/**
 *  校验最少输入n位的数字
 *
 *  @param leastLength n位
 *  @param number 数字
 */
+ (BOOL)yc_checkingNumberWithLeastLength:(NSString *)leastLength number:(NSString *)number;
@end
