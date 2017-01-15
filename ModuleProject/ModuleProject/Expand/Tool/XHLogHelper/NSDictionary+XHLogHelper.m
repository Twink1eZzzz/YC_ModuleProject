//
//  NSDictionary+XHLogHelper.m
//  XHLogHelperExample
//
//  Created by xiaohui on 16/7/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLogHelper

#import "NSDictionary+XHLogHelper.h"

@implementation NSDictionary (XHLogHelper)

#if DEBUG
- (NSString *)descriptionWithLocale:(nullable id)locale{

    NSString *logString;
    @try {
        
    logString=[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];

    } @catch (NSException *exception) {
        
        NSString *reason = [NSString stringWithFormat:@"reason:%@",exception.reason];
        logString = [NSString stringWithFormat:@"转换失败:\n%@,\n转换终止,输出如下:\n%@",reason,self.description];
        
    } @finally {
 
    }
    return logString;
}
#endif
@end
