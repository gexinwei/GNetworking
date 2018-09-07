//
//  GDESModel.m
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import "GDESModel.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation GDESModel

/**
 DES加密  CBC/kCCOptionPKCS7Padding
 
 @param source 需要加密的源数据
 @param key 加密key
 @param iv 偏移向量
 @return 加密后的数据
 */
+ (NSString *)encryptUseDES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv{
    
    NSString *ciphertext = nil;
    NSData *textData = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return ciphertext;
}

/**
 DES解密  CBC/kCCOptionPKCS7Padding
 
 @param source 需要解密的源数据
 @param key 解密key
 @param iv 偏移向量
 @return 解密后的数据
 */
+ (NSString *)decryptUseDES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv {
    
    NSString *ciphertext = nil;
    NSData *textData = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return ciphertext;
}

/**
 3DES加密
 
 @param source 需要加密的源数据
 @param key 加密key
 @param iv 偏移向量
 @return 加密后的数据
 */
+ (NSString *)encryptUse3DES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv {
    
    NSString *ciphertext = nil;
    NSData *textData = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySize3DES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return ciphertext;
}

/**
 3DES解密
 
 @param source 需要解密的源数据
 @param key 解密key
 @param iv 偏移向量
 @return 解密后的数据
 */
+ (NSString *)decryptUse3DES:(NSString *)source key:(NSString *)key iv:(const Byte[])iv {
    
    NSString *ciphertext = nil;
    NSData *textData = [source dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySize3DES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return ciphertext;
}

@end
