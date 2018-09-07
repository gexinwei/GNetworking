//
//  GMD5Model.h
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GMD5Model : NSObject

/**
 MD5加密
 
 @param source 需要加密的源数据
 @return 加密后的数据
 */
+ (NSString *)encryptMD5:(NSString *)source;

@end
