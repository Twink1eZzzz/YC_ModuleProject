//
//  NSDictionary+XHLogHelper.h
//  XHLogHelperExample
//
//  Created by xiaohui on 16/7/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLogHelper

#import <Foundation/Foundation.h>
/*
  NSLog打印 NSDictionary 时会自动进行如下操作,方便数组在线校验及格式化
 //1.自动补全缺失""
 //2.自动转换数组()转换为[]
 //3.自动转换unicode编码为中文
 */
@interface NSDictionary (XHLogHelper)

@end
