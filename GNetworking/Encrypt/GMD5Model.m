//
//  GMD5Model.m
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import "GMD5Model.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation GMD5Model

/**
 MD5加密
 
 @param source 需要加密的源数据
 @return 加密后的数据
 */
+ (NSString *)encryptMD5:(NSString *)source {
    
    NSString *ciphertext = nil;
    const char *sourceUTF8 = [source UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(sourceUTF8, (CC_LONG)strlen(sourceUTF8), digest);
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        ciphertext = [ciphertext stringByAppendingFormat:@"%c",digest[i]];
    }
    
    return ciphertext;
}

@end
