//
//  MDDNetConfig.h
//  MDD
//
//  Created by ge wei on 2018/9/3.
//

#import <GNetworking/GNetworking-umbrella.h>

@interface MDDNetConfig : GNetConfig <GNetConfigProtocol>

/**
 公用参数
 
 @return 公用参数
 */
+ (NSDictionary *)commonParam;

/**
 根据项目约定最终组装参数
 
 @param param 输入参数
 @return 输出参数
 */
+ (NSDictionary *)finalParam:(NSDictionary *)param;

@end
