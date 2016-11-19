//
//  ZRAFNRequests.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ZRAFNRequests : NSObject


/*!
 @method
 @brief       普通的get请求方法
 @discussion
 @param       urlPaths  请求地址
 @param       params    请求参数（NSDictionary）
 @result      返回请求结果
 */
+ (void)get:(NSString *)url
            parameters:(id)param
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure;

/*!
 @method
 @brief       普通的post请求（无上传图片）
 @discussion
 @param       urlPaths  请求地址
 @param       params    请求参数    (NSDictionary）
 @param       success   成功回调函数 (NSDictionary)
 @param       failure   失败回调函数 (NSError)
 @result      返回请求结果（block）
 */
+ (void)post:(NSString *)url
            parameters:(id)param
            success:(void (^)(id result))success
            failure:(void (^)(id error))failure;

/**
 *  上传图片（支持多张上传和单张上传）
 *
 *  @param url     上传地址
 *  @param param   除文件外的后台要求参数
 *  @param file    文件数组（文件流or数据流）
 *  @param fileKey 服务器用来解析的字段
 *  @param success 成功回调函数
 *  @param failure 失败回调函数
 */

+ (void)post:(NSString *)url
            parameters:(id)param
            imageFile:(NSArray*)file
            fileKey:(NSString*)fileKey
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure;





@end
