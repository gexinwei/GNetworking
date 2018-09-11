//
//  MDDNetConfig.m
//  MDD
//
//  Created by ge wei on 2018/9/3.
//

#import "MDDNetConfig.h"
#import <AdSupport/ASIdentifierManager.h>

@implementation MDDNetConfig

/**
 实现网络配置
 
 @return 网络配置对象
 */
+ (id)netConfig{
    return [[MDDNetConfig alloc] init];
}

/**
 提供的针对body公用参数 可以不实现
 
 @return 公用参数
 */
- (NSDictionary *)commonParams:(NSString *)url {
    return [MDDNetConfig commonParam];
}

/**
 提供的针对header公用参数 可以不实现
 
 @return 公用参数
 */
- (NSDictionary *)extraHeaderParams:(NSString *)url {
    return nil;
}

/**
 是否需要加密
 
 @param url 校验url
 @return 是/否 default否
 */
- (BOOL)needEncrypt:(NSString *)url {
    if ([url hasPrefix:@"http://mdd.apps365home.com/mdd_api.php"]) {
        return YES;
    }
    return NO;
}

/**
 是否需要解密
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needDecrypt:(NSString *)url {
    if ([url hasPrefix:@"http://mdd.apps365home.com/mdd_api.php"]) {
        return YES;
    }
    return NO;
}

/**
 加密类型
 
 @param url 校验url
 @return 加密类型
 */
- (EncryptType)typeOfEncrypt:(NSString *)url {
    if ([url hasPrefix:@"http://mdd.apps365home.com/mdd_api.php"]) {
        return EncryptType_3DES;
    }
    return EncryptType_CUSTOM;
}

/**
 解密类型
 
 @param url 校验url
 @return 解密类型
 */
- (EncryptType)typeOfDecrypt:(NSString *)url {
    if ([url hasPrefix:@"http://mdd.apps365home.com/mdd_api.php"]) {
        return EncryptType_3DES;
    }
    return EncryptType_CUSTOM;
}

/**
 加密key  非自定义加密类型使用
 
 @param type 加密类型
 @return 加密参数
 */
- (NSDictionary *)encryptKey:(EncryptType)type {
    if (type == EncryptType_3DES) {
        return @{DES_KEY:@"mddqkio9012345678901234567890123",
                 DES_IV:@"23456789"
                 };
    }
    return nil;
}

/**
 解密key 非自定义加密类型使用
 
 @param type 解密类型
 @return 解密参数
 */
- (NSDictionary *)decryptKey:(EncryptType)type {
    if (type == EncryptType_3DES) {
        return @{DES_KEY:@"mddqkio9012345678901234567890123",
                 DES_IV:@"23456789"
                 };
    }
    return nil;
}

/**
 key-value的key是否需要加密
 
 @return 是/否
 */
- (BOOL)sholdKeyEncrypt {
    return NO;
}

/**
 key-value的key是否需要解密
 
 @return 是/否
 */
- (BOOL)sholdKeyDecrypt {
    return NO;
}

/**
 自定义加密规则
 
 @param reqData 请求参数
 @return 请求参数加密结果
 */
- (id)customEncryptData:(id)reqData {
    return reqData;
}

/**
 自定义解密规则
 
 @param resData 返回参数
 @return 请求解密结果
 */
- (id)customDecryptData:(id)resData {
    return resData;
}

/**
 是否需要缓存
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needCache:(NSString *)url {
    return YES;
}

/**
 是否需要取消当前请求
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needCancleCurReq:(NSString *)url {
    return YES;
}

/**
 是否需要取消之前的请求
 
 @param url 校验url
 @return 是/否 default 否
 */
- (BOOL)needReplaceReq:(NSString *)url {
    return YES;
}

/**
 超时时间
 
 @param url 校验url
 @return 超时时间 default 20s
 */
- (float)timeoutDuration:(NSString *)url {
    return 30;
}

/**
 公用参数

 @return 公用参数
 */
+ (NSDictionary *)commonParam {
    NSMutableDictionary *commonParam = [NSMutableDictionary dictionary];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *IDFI = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    [commonParam setObject:version forKey:@"v"];
    [commonParam setObject:IDFI forKey:@"uuid"];
    [commonParam setObject:@"752" forKey:@"appid"];
    
    //推送id
    
    //定位信息
    
    return commonParam;
}

/**
 根据项目约定最终组装参数

 @param param 输入参数
 @return 输出参数
 */
+ (NSDictionary *)finalParam:(NSDictionary *)param {
    NSMutableDictionary *mParam = [NSMutableDictionary dictionary];
    [mParam addEntriesFromDictionary:param];
    [mParam addEntriesFromDictionary:[MDDNetConfig commonParam]];
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:mParam options:NSJSONWritingPrettyPrinted error:&error];
    NSString *paramJson = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return @{@"data":paramJson};
}

@end
