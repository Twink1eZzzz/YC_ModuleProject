//
//  NetworkTool.m
//  ModuleProject
//
//  Created by 李奕辰 on 2017/1/6.
//  Copyright © 2017年 Twinkle. All rights reserved.
//

#import "NetworkTool.h"
#import "XMNetworking.h"

@implementation NetworkTool
// 实现单利
YCSingletonM(NetworkTool)


//统一配置
/**
 @server 服务器地址
 @header 请求头
 @parameters 参数
 */
- (void)setupConfigWithServer:(NSString *)server Header:(NSDictionary *)header Parameters:(NSDictionary *)parameters {
    [XMCenter setupConfig:^(XMConfig *_Nonnull config) {
        config.generalServer = server;
        config.generalHeaders = header;
        config.generalParameters = parameters;
        config.generalUserInfo = nil;
        config.callbackQueue = dispatch_get_main_queue();
#ifdef DEGUG
        config.consoleLog = YES;
#endif
    }];
}

// GET 请求
/**
 @api 接口
 @parameters 参数
 @success 成功后返回的json
 @failure 失败后返回error
 */

- (void)GETMethodWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Success:(void (^)(id, NSString *))success Failure:(void (^)(NSError *))failure {
    [XMCenter sendRequest:^(XMRequest *_Nonnull request) {
        request.api = api;
        request.parameters = parameters;
        request.httpMethod = kXMHTTPMethodGET;
        request.requestType = kXMRequestNormal;
        request.timeoutInterval = 20;
    }           onSuccess:^(id _Nullable responseObject) {
        success(responseObject, responseObject[@"resultCode"]);
    }           onFailure:^(NSError *_Nullable error) {
        failure(error);
    }];
}

// POST 请求
/**
 @api 接口
 @parameters 参数
 @success 成功后返回的json
 @failure 失败后返回error
 */
- (void)POSTMethodWithApi:(NSString *)api Parameters:(NSDictionary *)parameters Success:(void (^)(id response, NSString *str))success Failure:(void (^)(NSError *error))failure {
    [XMCenter sendRequest:^(XMRequest *_Nonnull request) {
        request.api = api;
        request.parameters = parameters;
        request.httpMethod = kXMHTTPMethodPOST;
        request.requestType = kXMRequestNormal;
        request.timeoutInterval = 20;
    }           onSuccess:^(id _Nullable responseObject) {
        success(responseObject, responseObject[@"resultCode"]);
    }           onFailure:^(NSError *_Nullable error) {
        failure(error);
    }];

}


// 上传 请求 支持单、多图片上传
/**
 @api 接口
 @parameters 参数
 @ImageDataArray 图片NSData数组
 @progress 进度
 @success 成功后返回的json
 @failure 失败后返回error
 */
- (void)UpLoadMethodWithApi:(NSString *)api Parameters:(NSDictionary *)parameters ImageDataArray:(NSArray *)imageDataArry FileName:(NSString *)filename FileProgress:(void (^)(float))fileProgress Success:(void (^)(id, NSString *))success Failure:(void (^)(NSError *))failure {
    [XMCenter sendRequest:^(XMRequest *_Nonnull request) {
        request.api = api;
        request.parameters = parameters;
        request.requestType = kXMRequestUpload;
        request.timeoutInterval = 20;
        for (NSInteger i = 0; i < imageDataArry.count; i++) {

            [request addFormDataWithName:[NSString stringWithFormat:@"%@%ld", filename, i] fileName:[NSString stringWithFormat:@"%@%ld.jpg", filename, i] mimeType:@"image/jpeg" fileData:imageDataArry[i]];
        }

    }          onProgress:^(NSProgress *_Nonnull progress) {
        fileProgress(progress.fractionCompleted);
    }           onSuccess:^(id _Nullable responseObject) {
        success(responseObject, responseObject[@"resultCode"]);
    }           onFailure:^(NSError *_Nullable error) {
        failure(error);
    }];
}


- (void)DownLoadMethodWithUrl:(NSString *)url DownloadSavePath:(NSString *)downloadsavepath FileProgress:(void (^)(float fractionCompleted))fileProgress Success:(void (^)(id response, NSString *str))success Failure:(void (^)(NSError *error))failure {
    [XMCenter sendRequest:^(XMRequest *request) {
        request.url = url;
        request.downloadSavePath = downloadsavepath;
        request.requestType = kXMRequestDownload;
        request.timeoutInterval = 20;
    } onProgress:^(NSProgress *progress) {
        fileProgress(progress.fractionCompleted);
    } onSuccess:^(id responseObject) {
        success(responseObject,responseObject[@"resultCode"]);
    } onFailure:^(NSError *error) {
        failure(error);
    }];
}


@end
