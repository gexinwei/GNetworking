//
//  GNetworkingManager.h
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GNetworkingManager : NSObject

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
     failure:(void (^)(NSError *error))failure;

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
    failure:(void (^)(NSError *error))failure;

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
       failure:(void (^) (NSError *error))failure;

/**
 同步POST请求
 
 @param url 请求url
 @param param 请求参数
 @return 返回结果
 */
+ (id)sync_POST:(NSString *)url
                param:(NSDictionary *)param;

/**
 同步GET请求
 
 @param url 请求url
 @param param 请求参数
 @return 返回结果
 */
+ (id)sync_GET:(NSString *)url
               param:(NSDictionary *)param;

@end
