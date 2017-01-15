//
//  NetworkTool.h
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/6.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCSingleton.h"

@interface NetworkTool : NSObject
YCSingletonH(NetworkTool) // 单例声明


//统一配置
/**
 * @server 服务器地址
 * @header 请求头
 * @parameters 参数
 */
- (void)setupConfigWithServer:(NSString *)server Header:(NSDictionary *)header Parameters:(NSDictionary *)parameters;



// GET 请求
/**
 * @api 接口
 * @parameters 参数
 * @success 成功后返回的json
 * @failure 失败后返回error
 */
- (void)GETMethodWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Success:(void (^)(id response, NSString *str))success Failure:(void (^)(NSError *error))failure;

// POST 请求
/**
 * @api 接口
 * @parameters 参数
 * @success 成功后返回的json
 * @failure 失败后返回error
 */
- (void)POSTMethodWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Success:(void (^)(id response, NSString *str))success Failure:(void (^)(NSError *error))failure;


// 上传 请求
/**
 * @api 接口
 * @parameters 参数
 * @ImageDataArray 图片NSData数组
 * @progress 进度
 * @success 成功后返回的json
 * @failure 失败后返回error
 */
- (void)UpLoadMethodWithApi:(NSString *)api Parameters:(NSDictionary *)parameters ImageDataArray:(NSArray *)imageDataArry FileName:(NSString *)filename FileProgress:(void (^)(float fractionCompleted))fileProgress Success:(void (^)(id response, NSString *str))success Failure:(void (^)(NSError *error))failure;

// 下载请求
/**
 *
 * @param url 下载全路径
 * @param downloadsavepath 保存路径
 * @param fileProgress 进度
 * @param success 成功返回json
 * @param failure 失败返回error
 */
- (void)DownLoadMethodWithUrl:(NSString *)url DownloadSavePath:(NSString *)downloadsavepath FileProgress:(void (^)(float fractionCompleted))fileProgress Success:(void (^)(id response, NSString *str))success Failure:(void (^)(NSError *error))failure;
@end
