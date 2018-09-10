//
//  GNetConfig.h
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class GNetConfig;

typedef enum {
    EncryptType_NONE,       //无需加密
    EncryptType_CUSTOM,     //自定义类型加密
    EncryptType_DES,        //DES加密
    EncryptType_3DES,       //3DES加密
    EncryptType_MD5,        //MD5加密
    EncryptType_RSA,        //RSA加密
}EncryptType;

@protocol GNetConfigProtocol <NSObject>

@required

/**
 实现网络配置
 
 @return 网络配置对象
 */
+ (id)netConfig;

@optional

/**
 提供的针对body公用参数 可以不实现
 
 @return 公用参数
 */
- (NSDictionary *)commonParams:(NSString *)url;

/**
 提供的针对header公用参数 可以不实现
 
 @return 公用参数
 */
- (NSDictionary *)extraHeaderParams:(NSString *)url;

/**
 是否需要加密
 
 @param url 校验url
 @return 是/否 default否
 */
- (BOOL)needEncrypt:(NSString *)url;

/**
 是否需要解密
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needDecrypt:(NSString *)url;

/**
 加密类型
 
 @param url 校验url
 @return 加密类型
 */
- (EncryptType)typeOfEncrypt:(NSString *)url;

/**
 解密类型
 
 @param url 校验url
 @return 解密类型
 */
- (EncryptType)typeOfDecrypt:(NSString *)url;

/**
 加密key  非自定义加密类型使用
 
 @param type 加密类型
 @return 加密参数
 */
- (NSDictionary *)encryptKey:(EncryptType)type;

/**
 解密key 非自定义加密类型使用
 
 @param type 解密类型
 @return 解密参数
 */
- (NSDictionary *)decryptKey:(EncryptType)type;

/**
 key-value的key是否需要加密

 @return 是/否
 */
- (BOOL)sholdKeyEncrypt;

/**
 key-value的key是否需要解密
 
 @return 是/否
 */
- (BOOL)sholdKeyDecrypt;

/**
 自定义加密规则
 
 @param reqData 请求参数
 @return 请求参数加密结果
 */
- (id)customEncryptData:(id)reqData;

/**
 自定义解密规则
 
 @param resData 返回参数
 @return 请求解密结果
 */
- (id)customDecryptData:(id)resData;

/**
 是否需要缓存
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needCache:(NSString *)url;

/**
 是否需要取消当前请求
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needCancleCurReq:(NSString *)url;

/**
 是否需要取消之前的请求
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needReplaceReq:(NSString *)url;

/**
 超时时间
 
 @param url 校验url
 @return 超时时间 default 20s
 */
- (float)timeoutDuration:(NSString *)url;

@end

FOUNDATION_EXTERN GNetConfig<GNetConfigProtocol> *NETConfig;

@interface GNetConfig : NSObject

/**
 注册网络配置
 */
+ (void)registerNetConfig;

/**
 获取网络请求manager单利
 
 @return 网络请求manager单利
 */
- (AFHTTPSessionManager *)manager;

/**
 添加请求，防止重复请求
 
 @param url 请求url+请求params
 */
- (BOOL)addRequest:(NSString *)url;

/**
 移除请求，请求完成时移除
 
 @param url 请求url+请求params
 */
- (BOOL)removeRequest:(NSString *)url;

@end
