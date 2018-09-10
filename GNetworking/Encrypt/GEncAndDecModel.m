//
//  GEncAndDecModel.m
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import "GEncAndDecModel.h"
#import "GRSAModel.h"
#import "GMD5Model.h"
#import "GDESModel.h"

@implementation GEncAndDecModel

/**
 加密
 
 @param source 需要加密数据源
 @param type 加密类型
 @return 加密后的数据
 */
+ (id)ENC:(id)source type:(EncryptType)type {
    if ([source isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *keys = ((NSDictionary *)source).allKeys;
        for (NSString *key in keys) {
            NSString *encKey = key;
            id value = [((NSDictionary *)source) objectForKey:key];
            if (NETConfig && [NETConfig respondsToSelector:@selector(sholdKeyEncrypt)]) {
                BOOL should = [NETConfig sholdKeyEncrypt];
                if (should) {
                    encKey = [GEncAndDecModel ENC:key type:type];
                }
            }
            id encValue = [GEncAndDecModel ENC:value type:type];
            [dict setObject:encValue forKey:encKey];
        }
        return dict;
    } else if ([source isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in ((NSArray *)source)) {
            [array addObject:[GEncAndDecModel ENC:dic type:type]];
        }
        return array;
    } else {
        id encValue = nil;
        switch (type) {
            case EncryptType_CUSTOM:
            {
                if (NETConfig && [NETConfig respondsToSelector:@selector(customEncryptData:)]) {
                    encValue = [NETConfig customEncryptData:source];
                } else {
                    encValue = [NSError errorWithDomain:@"自定义加密方法（QBNetConfigProtocol:customEncryedData）未实现" code:0 userInfo:nil];
                }
            }
                break;
            case EncryptType_DES:
            {
                NSDictionary *keyDict = nil;
                if (NETConfig && [NETConfig respondsToSelector:@selector(encryptKey:)]) {
                    keyDict = [NETConfig encryptKey:type];
                    NSString *key = keyDict[DES_KEY];
                    NSArray *ivArr = keyDict[DES_IV];
                    Byte iv[ivArr.count];
                    for (int i = 0; i < ivArr.count; i++) {
                        iv[i] = [[ivArr objectAtIndex:i] intValue];
                    }
                    if (key && *iv && ivArr.count>0) {
                        encValue = [GDESModel encryptUseDES:source key:key iv:iv];
                    } else {
                        encValue = [NSError errorWithDomain:@"DES加密方法获取加密参数 DES_KEY、DES_IV失败" code:0 userInfo:nil];
                    }
                } else {
                    encValue = [NSError errorWithDomain:@"DES加密方法获取加密参数（QBNetConfigProtocol:encryptKey）未实现" code:0 userInfo:nil];
                }
            }
                break;
            case EncryptType_3DES:
            {
                NSDictionary *keyDict = nil;
                if (NETConfig && [NETConfig respondsToSelector:@selector(encryptKey:)]) {
                    keyDict = [NETConfig encryptKey:type];
                    NSString *key = keyDict[DES_KEY];
                    NSArray *ivArr = keyDict[DES_IV];
                    Byte iv[ivArr.count];
                    for (int i = 0; i < ivArr.count; i++) {
                        iv[i] = [[ivArr objectAtIndex:i] intValue];
                    }
                    if (key && *iv && ivArr.count>0) {
                        encValue = [GDESModel encryptUse3DES:source key:key iv:iv];
                    } else {
                        encValue = [NSError errorWithDomain:@"3DES加密方法获取加密参数 DES_KEY、DES_IV失败" code:0 userInfo:nil];
                    }
                } else {
                    encValue = [NSError errorWithDomain:@"3DES加密方法获取加密参数（QBNetConfigProtocol:encryptKey）未实现" code:0 userInfo:nil];
                }
            }
                break;
            case EncryptType_MD5:
            {
                encValue = [GMD5Model encryptMD5:source];
            }
                break;
            case EncryptType_RSA:
            {
                NSDictionary *keyDict = nil;
                if (NETConfig && [NETConfig respondsToSelector:@selector(encryptKey:)]) {
                    keyDict = [NETConfig encryptKey:type];
                    NSString *pubKey = keyDict[RSA_PUB_KEY];
                    NSString *pubKeyPath = keyDict[RSA_PUB_KEYPATCH];
                    if (pubKey && ![pubKey isEqualToString:@""]) {
                        encValue = [GRSAModel encryptString:source publicKey:pubKey];
                    } else if (pubKeyPath && ![pubKeyPath isEqualToString:@""]) {
                        encValue = [GRSAModel encryptString:source publicKeyWithContentsOfFile:pubKeyPath];
                    } else {
                        encValue = [NSError errorWithDomain:@"RSA加密方法获取加密参数 RSA_PUB_KEY、RSA_PUB_KEYPATCH失败" code:0 userInfo:nil];
                    }
                } else {
                    encValue = [NSError errorWithDomain:@"RSA加密方法获取加密参数（QBNetConfigProtocol:encryptKey）未实现" code:0 userInfo:nil];
                }
            }
                break;
                
            default:
            {
                encValue = [NSError errorWithDomain:[NSString stringWithFormat:@"未识别的加密类型：（%d）",type] code:0 userInfo:nil];
            }
                break;
        }
        return encValue;
    }
}

/**
 解密
 
 @param source 需要解密数据源
 @param type 解密类型
 @return 解密后的数据
 */
+ (id)DEC:(id)source type:(EncryptType)type {
    if ([source isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *keys = ((NSDictionary *)source).allKeys;
        for (NSString *key in keys) {
            
            NSString *decKey = key;
            id value = [((NSDictionary *)source) objectForKey:key];
            if (NETConfig && [NETConfig respondsToSelector:@selector(sholdKeyDecrypt)]) {
                BOOL should = [NETConfig sholdKeyDecrypt];
                if (should) {
                    decKey = [GEncAndDecModel DEC:key type:type];
                }
            }
            
            id decValue = [GEncAndDecModel DEC:value type:type];
            [dict setObject:decValue forKey:decKey];
        }
        return dict;
    } else if ([source isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in ((NSArray *)source)) {
            [array addObject:[GEncAndDecModel DEC:dic type:type]];
        }
        return array;
    } else {
        id encValue = nil;
        switch (type) {
            case EncryptType_CUSTOM:
            {
                if (NETConfig && [NETConfig respondsToSelector:@selector(customDecryptData:)]) {
                    encValue = [NETConfig customDecryptData:source];
                } else {
                    encValue = [NSError errorWithDomain:@"自定义解密方法（QBNetConfigProtocol:customDecryptData）未实现" code:0 userInfo:nil];
                }
            }
                break;
            case EncryptType_DES:
            {
                NSDictionary *keyDict = nil;
                if (NETConfig && [NETConfig respondsToSelector:@selector(decryptKey:)]) {
                    keyDict = [NETConfig decryptKey:type];
                    NSString *key = keyDict[DES_KEY];
                    NSArray *ivArr = keyDict[DES_IV];
                    Byte iv[ivArr.count];
                    for (int i = 0; i < ivArr.count; i++) {
                        iv[i] = [[ivArr objectAtIndex:i] intValue];
                    }
                    if (key && *iv && ivArr.count>0) {
                        encValue = [GDESModel decryptUseDES:source key:key iv:iv];
                    } else {
                        encValue = [NSError errorWithDomain:@"DES解密方法获取解密参数 DES_KEY、DES_IV失败" code:0 userInfo:nil];
                    }
                } else {
                    encValue = [NSError errorWithDomain:@"DES解密方法获取解密参数（QBNetConfigProtocol:decryptKey）未实现" code:0 userInfo:nil];
                }
            }
                break;
            case EncryptType_3DES:
            {
                NSDictionary *keyDict = nil;
                if (NETConfig && [NETConfig respondsToSelector:@selector(decryptKey:)]) {
                    keyDict = [NETConfig decryptKey:type];
                    NSString *key = keyDict[DES_KEY];
                    NSArray *ivArr = keyDict[DES_IV];
                    Byte iv[ivArr.count];
                    for (int i = 0; i < ivArr.count; i++) {
                        iv[i] = [[ivArr objectAtIndex:i] intValue];
                    }
                    if (key && *iv && ivArr.count>0) {
                        encValue = [GDESModel decryptUse3DES:source key:key iv:iv];
                    } else {
                        encValue = [NSError errorWithDomain:@"3DES解密方法获取解密参数 DES_KEY、DES_IV失败" code:0 userInfo:nil];
                    }
                } else {
                    encValue = [NSError errorWithDomain:@"3DES解密方法获取解密参数（QBNetConfigProtocol:decryptKey）未实现" code:0 userInfo:nil];
                }
            }
                break;
            case EncryptType_MD5:
            {
                encValue = [GMD5Model encryptMD5:source];
            }
                break;
            case EncryptType_RSA:
            {
                NSDictionary *keyDict = nil;
                if (NETConfig && [NETConfig respondsToSelector:@selector(decryptKey:)]) {
                    keyDict = [NETConfig decryptKey:type];
                    NSString *priKey = keyDict[RSA_PRI_KEY];
                    NSString *priKeyPath = keyDict[RSA_PRI_KEYPATCH];
                    NSString *pwd = keyDict[RSA_PRI_PSW];
                    if (priKey && ![priKey isEqualToString:@""]) {
                        encValue = [GRSAModel decryptString:source privateKey:priKey];
                    } else if (priKeyPath && ![priKeyPath isEqualToString:@""] && pwd && ![pwd isEqualToString:@""]) {
                        encValue = [GRSAModel decryptString:source privateKeyWithContentsOfFile:priKeyPath password:pwd];
                    } else {
                        encValue = [NSError errorWithDomain:@"RSA解密方法获取解密参数 RSA_PUB_KEY、RSA_PUB_KEYPATCH、RSA_PRI_PSW失败" code:0 userInfo:nil];
                    }
                } else {
                    encValue = [NSError errorWithDomain:@"RSA解密方法获取解密参数（QBNetConfigProtocol:decryptKey）未实现" code:0 userInfo:nil];
                }
            }
                break;
                
            default:
            {
                encValue = [NSError errorWithDomain:[NSString stringWithFormat:@"未识别的解密类型：（%d）",type] code:0 userInfo:nil];
            }
                break;
        }
        return encValue;
    }
}

@end
