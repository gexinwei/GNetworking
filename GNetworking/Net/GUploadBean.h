//
//  GUploadBean.h
//  GNetworking
//
//  Created by ge wei on 2017/3/30.
//  Copyright © 2017年 gxw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum UPLOAD_TYPE{
    UPLOAD_TYPE_FILE            = 0,    // 文件
    UPLOAD_TYPE_DATA            = 1,    // 二进制
    UPLOAD_TYPE_INPUTSTREAM     = 2,    // 输入流
    UPLOAD_TYPE_HEAD            = 3,    // 请求头
}UploadType;

@interface GUploadBean : NSObject


/**
 type of upload source
 */
@property (nonatomic, assign) UploadType    type;


/**
 url of file in filesystem
 */
@property (nonatomic, strong) NSURL         *url;
/**
 byte of upload
 */
@property (nonatomic, strong) NSData        *data;
/**
 The data to be encoded and appended to the form data. This parameter must not be `nil`.
 */
@property (nonatomic, strong) NSData        *body;
/**
 inputstream of upload
 */
@property (nonatomic, strong) NSInputStream *inputStream;
/**
 headers of upload
 */
@property (nonatomic, strong) NSDictionary  *headers;



/**
 name property of upload
 */
@property (nonatomic, strong) NSString      *name;
/**
 filename property of upload
 */
@property (nonatomic, strong) NSString      *fileName;
/**
 mimeType of request
 */
@property (nonatomic, strong) NSString      *mimeType;
/**
 The length of the specified input stream in bytes.
 */
@property (nonatomic, assign) NSInteger     length;


@end
