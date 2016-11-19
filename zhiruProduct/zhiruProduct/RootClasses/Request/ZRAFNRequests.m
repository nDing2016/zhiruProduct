//
//  ZRAFNRequests.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  网络请求层
//code 细节
//S000	success
//S001	服务端异常
//S002	参数格式错误
//C001	用户登陆失效
//C002	无权限
//C003	不存在用户
//

#import "ZRAFNRequests.h"
#import "ZRUser.h"
#import "ZRUserTool.h"
static NSTimeInterval const KSTimeOutInterval = 30;

@implementation ZRAFNRequests

#pragma mark -- get请求
+ (void)get:(NSString *)url
            parameters:(id)param
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //网络请求时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = KSTimeOutInterval;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [session GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //JSON解析
        //直接将JSON传出去
        success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark -- post请求 不带图片
+ (void)post:(NSString *)url
  parameters:(id)param
     success:(void (^)(id result))success
     failure:(void (^)(id error))failure{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];

    session.responseSerializer =[AFJSONResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];

    //网络请求时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = KSTimeOutInterval;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
//    //增加这几行代码；解决3840错误
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [session setSecurityPolicy:securityPolicy];
    
    //===============设置请求头===============//
    



        if (Token != nil) {
            [session.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
        }

    [session POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //响应体
        
        //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dict = responseObject;
        if ([dict[@"code"]  isEqualToString:@"S000"]) { //请求成功
            success(dict);
        }
        else if ([dict[@"code"] isEqualToString:@"S001"]) { //服务端异常
         
        }
        else if([dict[@"code"]isEqualToString:@"S002"]) {  //参数格式错误
         
        }
        else if([dict[@"code"]isEqualToString:@"C001"]) {  //用户登陆失效
            success(dict);
        }
        else if([dict[@"code"]isEqualToString:@"C002"]) {  //无权限
            
        }
        else if([dict[@"code"]isEqualToString:@"C003"]) {  //不存在用户
            success(dict);
        }
        else if([dict[@"code"]isEqualToString:@"C004"]){
            success(dict);
        } else {
            success(dict);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


#pragma mark -- post请求 上传图片
+ (void)post:(NSString *)url
            parameters:(id)param
            imageFile:(NSArray*)file
            fileKey:(NSString*)fileKey
            success:(void (^)(id result))success
            failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //网络请求时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = KSTimeOutInterval;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    if (Token != nil) {

        [session.requestSerializer setValue:Token forHTTPHeaderField:@"token"];
        
    }
    [session POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (file.count >0) {
            for(int i=0;i<file.count;i++){
                
                [formData appendPartWithFileData:file[i][@"imageData"] name:[NSString stringWithFormat:@"fileImg%ld",(long)i] fileName:[NSString stringWithFormat:@"fileImg%ld",(long)i] mimeType:@"image/jpg/png/jpeg"];
                
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary *dict = responseObject;
        if ([dict[@"code"]  isEqualToString:@"S000"]) { //请求成功
            success(dict);
        }
        else if ([dict[@"code"] isEqualToString:@"S001"]) { //服务端异常
            
        }
        else if([dict[@"code"]isEqualToString:@"S002"]) {  //参数格式错误
            
        }
        else if([dict[@"code"]isEqualToString:@"C001"]) {  //用户登陆失效
            
        }
        else if([dict[@"code"]isEqualToString:@"C002"]) {  //无权限
            
        }
        else if([dict[@"code"]isEqualToString:@"C003"]) {  //不存在用户
            
        } else {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}



@end
