//
//  GNetworkingManager.m
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import "GNetworkingManager.h"
#import "GEncAndDecModel.h"
#import "GNetConfig.h"
#import "GUploadBean.h"
#import <AFNetworking/AFNetworking.h>

#define CONTENT_TYPES @"text/html"

@implementation GNetworkingManager

/**
 POST请求
 
 @param url 请求链接
 @param param 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)url
       param:(NSDictionary *)param
     success:(void (^)(NSDictionary *responseObject))success
     failure:(void (^)(NSError *error))failure {
    //获取公用参数
    NSDictionary *commonParams = nil;
    if ([NETConfig respondsToSelector:@selector(commonParams:)]) {
        commonParams = [NETConfig commonParams:url];
    }
    
    //分装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:param];
    [params addEntriesFromDictionary:commonParams];
    
    //判断数据是否需要加密
    if ([NETConfig respondsToSelector:@selector(needEncrypt:)] && [NETConfig needEncrypt:url]) {
        if ([NETConfig respondsToSelector:@selector(typeOfEncrypt:)]) {
            EncryptType type = [NETConfig typeOfEncrypt:url];
            params = [GEncAndDecModel ENC:params type:type];
        } else {
            NSLog(@"未实现NETConfig方法：typeOfEncrypt:");
        }
    }
    
    AFHTTPSessionManager *manager = [NETConfig manager];
    
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    [serializer.acceptableContentTypes setByAddingObject:CONTENT_TYPES];
    manager.responseSerializer = serializer;
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(extraHeaderParams:)]) {
        NSDictionary *dict = [NETConfig extraHeaderParams:url];
        NSArray *allKeys = [dict allKeys];
        for (NSString *key in allKeys) {
            [manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
        }
    }
    
    NSString *paramsURL = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *singleURL = [NSString stringWithFormat:@"%@+%@",url,paramsURL];
    if (![NETConfig addRequest:singleURL]) {
        NSError *error = [NSError errorWithDomain:@"不要频繁请求" code:1024 userInfo:nil];
        failure(error);
        return;
    }
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(timeoutDuration:)]) {
        float time = [NETConfig timeoutDuration:url];
        if (time>0) {
            manager.requestSerializer.timeoutInterval = time;
        }
    }
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NETConfig removeRequest:singleURL];
        if ([NETConfig respondsToSelector:@selector(needDecrypt:)] && [NETConfig needDecrypt:url]) {
            if ([NETConfig respondsToSelector:@selector(typeOfDecrypt:)]) {
                EncryptType type = [NETConfig typeOfDecrypt:url];
                responseObject = [GEncAndDecModel DEC:responseObject type:type];
            } else {
                NSLog(@"未实现NETConfig方法：typeOfDecrypt:");
            }
        }
        
        id result;
        if (responseObject != nil) {
            result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        }
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NETConfig removeRequest:singleURL];
        failure(error);
    }];
}

/**
 GET请求
 
 @param url 请求链接
 @param param 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)GET:(NSString *)url
      param:(NSDictionary *)param
    success:(void (^)(NSDictionary *responseObject))success
    failure:(void (^)(NSError *error))failure {
    //获取公用参数
    NSDictionary *commonParams = nil;
    if ([NETConfig respondsToSelector:@selector(commonParams:)]) {
        commonParams = [NETConfig commonParams:url];
    }
    
    //分装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:param];
    [params addEntriesFromDictionary:commonParams];
    
    //判断数据是否需要加密
    if ([NETConfig respondsToSelector:@selector(needEncrypt:)] && [NETConfig needEncrypt:url]) {
        if ([NETConfig respondsToSelector:@selector(typeOfEncrypt:)]) {
            EncryptType type = [NETConfig typeOfEncrypt:url];
            params = [GEncAndDecModel ENC:params type:type];
        } else {
            NSLog(@"未实现NETConfig方法：typeOfEncrypt:");
        }
    }
    
    AFHTTPSessionManager *manager = [NETConfig manager];
    
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    [serializer.acceptableContentTypes setByAddingObject:CONTENT_TYPES];
    manager.responseSerializer = serializer;
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(extraHeaderParams:)]) {
        NSDictionary *dict = [NETConfig extraHeaderParams:url];
        NSArray *allKeys = [dict allKeys];
        for (NSString *key in allKeys) {
            [manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
        }
    }
    
    NSString *paramsURL = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *singleURL = [NSString stringWithFormat:@"%@+%@",url,paramsURL];
    if (![NETConfig addRequest:singleURL]) {
        NSError *error = [NSError errorWithDomain:@"不要频繁请求" code:1024 userInfo:nil];
        failure(error);
        return;
    }
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(timeoutDuration:)]) {
        float time = [NETConfig timeoutDuration:url];
        if (time>0) {
            manager.requestSerializer.timeoutInterval = time;
        }
    }
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NETConfig removeRequest:singleURL];
        if ([NETConfig respondsToSelector:@selector(needDecrypt:)] && [NETConfig needDecrypt:url]) {
            if ([NETConfig respondsToSelector:@selector(typeOfDecrypt:)]) {
                EncryptType type = [NETConfig typeOfDecrypt:url];
                responseObject = [GEncAndDecModel DEC:responseObject type:type];
            } else {
                NSLog(@"未实现NETConfig方法：typeOfDecrypt:");
            }
        }
        
        id result;
        if (responseObject != nil) {
            result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        }
        success(result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NETConfig removeRequest:singleURL];
        failure(error);
    }];
}

/**
 上传
 
 @param url 请求链接
 @param param 参数
 @param items 需要上传的数据
 @param uploadProgressBlock 进度
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)UPLOAD:(NSString *)url
         param:(NSDictionary *)param
         items:(NSArray *)items
      progress:(void (^)(NSProgress *uploadProgress)) uploadProgressBlock
       success:(void (^) (NSDictionary * responseObject))success
       failure:(void (^) (NSError *error))failure {
    
    //获取公用参数
    NSDictionary *commonParams = nil;
    if ([NETConfig respondsToSelector:@selector(commonParams:)]) {
        commonParams = [NETConfig commonParams:url];
    }
    
    //分装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:param];
    [params addEntriesFromDictionary:commonParams];
    
    //判断数据是否需要加密
    if ([NETConfig respondsToSelector:@selector(needEncrypt:)] && [NETConfig needEncrypt:url]) {
        if ([NETConfig respondsToSelector:@selector(typeOfEncrypt:)]) {
            EncryptType type = [NETConfig typeOfEncrypt:url];
            params = [GEncAndDecModel ENC:params type:type];
        } else {
            NSLog(@"未实现NETConfig方法：typeOfEncrypt:");
        }
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (GUploadBean *bean in items) {
            switch (bean.type) {
                case UPLOAD_TYPE_FILE:
                {
                    NSError *error;
                    [formData appendPartWithFileURL:bean.url name:bean.name fileName:bean.fileName mimeType:bean.mimeType error:&error];
                    if (error) {
                        failure(error);
                        return;
                    }
                }
                    break;
                case UPLOAD_TYPE_DATA:
                {
                    [formData appendPartWithFileData:bean.data name:bean.name fileName:bean.fileName mimeType:bean.mimeType];
                }
                    break;
                case UPLOAD_TYPE_INPUTSTREAM:
                {
                    [formData appendPartWithInputStream:bean.inputStream name:bean.name fileName:bean.fileName length:bean.length mimeType:bean.mimeType];
                }
                    break;
                case UPLOAD_TYPE_HEAD:
                {
                    [formData appendPartWithHeaders:bean.headers body:bean.body];
                }
                    break;
                    
                default:
                {
                    [formData appendPartWithFormData:bean.data name:bean.name];
                }
                    break;
            }
        }
    } error:nil];
    
    AFHTTPSessionManager *manager = [NETConfig manager];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    [serializer.acceptableContentTypes setByAddingObject:CONTENT_TYPES];
    manager.responseSerializer = serializer;
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(extraHeaderParams:)]) {
        NSDictionary *dict = [NETConfig extraHeaderParams:url];
        NSArray *allKeys = [dict allKeys];
        for (NSString *key in allKeys) {
            [manager.requestSerializer setValue:dict[key] forHTTPHeaderField:key];
        }
    }
    
    NSString *paramsURL = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *singleURL = [NSString stringWithFormat:@"%@+%@",url,paramsURL];
    if (![NETConfig addRequest:singleURL]) {
        NSError *error = [NSError errorWithDomain:@"不要频繁请求" code:1024 userInfo:nil];
        failure(error);
        return;
    }
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(timeoutDuration:)]) {
        float time = [NETConfig timeoutDuration:url];
        if (time>0) {
            request.timeoutInterval = time;
        }
    }
    
    NSURLSessionUploadTask *uploadTask;
    
    uploadTask = [manager uploadTaskWithStreamedRequest:request
                                               progress:uploadProgressBlock
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          
                                          [NETConfig removeRequest:singleURL];
                                          if (error) {
                                              failure(error);
                                          } else {
                                              if ([NETConfig respondsToSelector:@selector(needDecrypt:)] && [NETConfig needDecrypt:url]) {
                                                  if ([NETConfig respondsToSelector:@selector(typeOfDecrypt:)]) {
                                                      EncryptType type = [NETConfig typeOfDecrypt:url];
                                                      responseObject = [GEncAndDecModel DEC:responseObject type:type];
                                                  } else {
                                                      NSLog(@"未实现NETConfig方法：typeOfDecrypt:");
                                                  }
                                              }
                                              
                                              id result;
                                              if (responseObject != nil) {
                                                  result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
                                              }
                                              success(result);
                                          }
                                          
                                      }];
    
    [uploadTask resume];
}

/**
 同步POST请求

 @param url 请求url
 @param param 请求参数
 @return 返回结果
 */
+ (id)sync_POST:(NSString *)url
           param:(NSDictionary *)param {
    
    //获取公用参数
    NSDictionary *commonParams = nil;
    if ([NETConfig respondsToSelector:@selector(commonParams:)]) {
        commonParams = [NETConfig commonParams:url];
    }
    
    //分装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:param];
    [params addEntriesFromDictionary:commonParams];
    
    //判断数据是否需要加密
    if ([NETConfig respondsToSelector:@selector(needEncrypt:)] && [NETConfig needEncrypt:url]) {
        if ([NETConfig respondsToSelector:@selector(typeOfEncrypt:)]) {
            EncryptType type = [NETConfig typeOfEncrypt:url];
            params = [GEncAndDecModel ENC:params type:type];
        } else {
            NSLog(@"未实现NETConfig方法：typeOfEncrypt:");
        }
    }
    
    NSString *paramsURL = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *singleURL = [NSString stringWithFormat:@"%@+%@",url,paramsURL];
    if (![NETConfig addRequest:singleURL]) {
        NSError *error = [NSError errorWithDomain:@"不要频繁请求" code:1024 userInfo:nil];
        return error;
    }
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSString *query = AFQueryStringFromParameters(params);
    if (!query) {
        query = @"";
    }
    if (![request valueForHTTPHeaderField:@"Content-Type"]) {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    [request setHTTPBody:[query dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(extraHeaderParams:)]) {
        NSDictionary *dict = [NETConfig extraHeaderParams:url];
        NSArray *allKeys = [dict allKeys];
        for (NSString *key in allKeys) {
            [request setValue:dict[key] forHTTPHeaderField:key];
        }
    }
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(timeoutDuration:)]) {
        float time = [NETConfig timeoutDuration:url];
        if (time>0) {
            request.timeoutInterval = time;
        }
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block id data = nil;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError) {
        
        [NETConfig removeRequest:singleURL];
        if (taskData && taskResponse) {
            id responseObject = taskData;
            if ([NETConfig respondsToSelector:@selector(needDecrypt:)] && [NETConfig needDecrypt:url]) {
                if ([NETConfig respondsToSelector:@selector(typeOfDecrypt:)]) {
                    EncryptType type = [NETConfig typeOfDecrypt:url];
                    responseObject = [GEncAndDecModel DEC:taskData type:type];
                } else {
                    NSLog(@"未实现NETConfig方法：typeOfDecrypt:");
                }
            }
            
            if (responseObject != nil) {
                data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
            }
            
            
        } else if (taskError) {
            data = taskError;
        }
        
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return data;
}

/**
 同步GET请求
 
 @param url 请求url
 @param param 请求参数
 @return 返回结果
 */
+ (id)sync_GET:(NSString *)url
           param:(NSDictionary *)param {

    //获取公用参数
    NSDictionary *commonParams = nil;
    if ([NETConfig respondsToSelector:@selector(commonParams:)]) {
        commonParams = [NETConfig commonParams:url];
    }
    
    //分装参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:param];
    [params addEntriesFromDictionary:commonParams];
    
    //判断数据是否需要加密
    if ([NETConfig respondsToSelector:@selector(needEncrypt:)] && [NETConfig needEncrypt:url]) {
        if ([NETConfig respondsToSelector:@selector(typeOfEncrypt:)]) {
            EncryptType type = [NETConfig typeOfEncrypt:url];
            params = [GEncAndDecModel ENC:params type:type];
        } else {
            NSLog(@"未实现NETConfig方法：typeOfEncrypt:");
        }
    }
    
    NSString *paramsURL = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *singleURL = [NSString stringWithFormat:@"%@+%@",url,paramsURL];
    if (![NETConfig addRequest:singleURL]) {
        NSError *error = [NSError errorWithDomain:@"不要频繁请求" code:1024 userInfo:nil];
        return error;
    }
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSString *query = AFQueryStringFromParameters(params);
    if (query && query.length > 0) {
        request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:request.URL.query ? @"&%@" : @"?%@", query]];
    }
    
    if (NETConfig && [NETConfig respondsToSelector:@selector(extraHeaderParams:)]) {
        NSDictionary *dict = [NETConfig extraHeaderParams:url];
        NSArray *allKeys = [dict allKeys];
        for (NSString *key in allKeys) {
            [request setValue:dict[key] forHTTPHeaderField:key];
        }
    }
    if (NETConfig && [NETConfig respondsToSelector:@selector(timeoutDuration:)]) {
        float time = [NETConfig timeoutDuration:url];
        if (time>0) {
            request.timeoutInterval = time;
        }
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __block id data = nil;
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *taskError) {
        
        [NETConfig removeRequest:singleURL];
        if (taskData && taskResponse) {
            id responseObject = taskData;
            if ([NETConfig respondsToSelector:@selector(needDecrypt:)] && [NETConfig needDecrypt:url]) {
                if ([NETConfig respondsToSelector:@selector(typeOfDecrypt:)]) {
                    EncryptType type = [NETConfig typeOfDecrypt:url];
                    responseObject = [GEncAndDecModel DEC:taskData type:type];
                } else {
                    NSLog(@"未实现NETConfig方法：typeOfDecrypt:");
                }
            }
            
            if (responseObject != nil) {
                data = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
            }
            
            
        } else if (taskError) {
            data = taskError;
        }
        
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return data;
}


@end
