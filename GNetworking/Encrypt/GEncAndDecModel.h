//
//  GEncAndDecModel.h
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GNetConfig.h"


#define DES_KEY             @"DES_KEY"
#define DES_IV              @"DES_IV"
#define RSA_PUB_KEY         @"RSA_PUB_KEY"
#define RSA_PUB_KEYPATCH    @"RSA_PUB_KEYPATCH"
#define RSA_PRI_KEY         @"RSA_PRI_KEY"
#define RSA_PRI_KEYPATCH    @"RSA_PRI_KEYPATCH"
#define RSA_PRI_PSW         @"RSA_PRI_PSW"


@interface GEncAndDecModel : NSObject

/**
 加密
 
 @param source 需要加密数据源
 @param type 加密类型
 @return 加密后的数据
 */
+ (id)ENC:(id)source type:(EncryptType)type;

/**
 解密
 
 @param source 需要解密数据源
 @param type 解密类型
 @return 解密后的数据
 */
+ (id)DEC:(id)source type:(EncryptType)type;

@end
