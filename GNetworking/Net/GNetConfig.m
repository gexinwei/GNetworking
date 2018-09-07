//
//  GNetConfig.m
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import "GNetConfig.h"

GNetConfig<GNetConfigProtocol> *NETConfig = nil;

@interface GNetConfig ()

@property (nonatomic, strong) NSMutableDictionary  *cacheDict;

@property (nonatomic, strong) AFHTTPSessionManager  *manager;

@end

@implementation GNetConfig

+ (void)registerNetConfig {
    if (![self conformsToProtocol:@protocol(GNetConfigProtocol)]) {
        NSAssert(NO, @"子类必须实现QBNetConfigProtocol这个protocol");
        return;
    } else {
        Class<GNetConfigProtocol> class = self;
        GNetConfig<GNetConfigProtocol> *config = [class netConfig];
        NETConfig = config;
    }
}

- (id)init {
    self = [super init];
    if (self) {
        self.cacheDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/**
 获取网络请求manager单利

 @return 网络请求manager单利
 */
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

/**
 添加请求，防止重复请求

 @param url 请求url+请求params
 */
- (BOOL)addRequest:(NSString *)url {
    NSString *obj = [self.cacheDict objectForKey:url];
    if (obj && [obj isEqualToString:url]) {
        return NO;
    }
    [self.cacheDict setObject:url forKey:url];
    return YES;
}

/**
 移除请求，请求完成时移除

 @param url 请求url+请求params
 */
- (BOOL)removeRequest:(NSString *)url {
    NSString *obj = [self.cacheDict objectForKey:url];
    if (obj && [obj isEqualToString:url]) {
        [self.cacheDict removeObjectForKey:url];
        return YES;
    }
    return NO;
}

@end
