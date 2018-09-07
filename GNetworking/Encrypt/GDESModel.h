//
//  GDESModel.h
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDESModel : NSObject

/**
 DES加密
 
 @param source 需要加密的源数据
 @param key 加密key
 @param iv 偏移向量
 @return 加密后的数据
 */
+ (NSString *)encryptUseDES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv;

/**
 DES解密
 
 @param source 需要解密的源数据
 @param key 解密key
 @param iv 偏移向量
 @return 解密后的数据
 */
+ (NSString *)decryptUseDES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv;



/**
 3DES加密
 
 @param source 需要加密的源数据
 @param key 加密key
 @param iv 偏移向量
 @return 加密后的数据
 */
+ (NSString *)encryptUse3DES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv;

/**
 3DES解密
 
 @param source 需要解密的源数据
 @param key 解密key
 @param iv 偏移向量
 @return 解密后的数据
 */
+ (NSString *)decryptUse3DES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv;

@end
