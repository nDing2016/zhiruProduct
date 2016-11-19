//
//  ZRCommentRequest.m
//  zhiruProduct
//
//  Created by nanding on 16/11/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRCommentRequest.h"

static NSString * const zmyBusinessComment= @"user/myBusinessComment";


@implementation ZRCommentRequest


/**
 *  我的评论－店铺评论
 *
 *  @param screen   筛选,0全部，1好评，2差评，3带图
 *  @param rows     条数
 *  @param page     页数
 *  @param callback 回调
 */
+ (void)requestForMyBusinessCommentWithScreen:(NSString *)screen
                                         Rows:(NSString *)rows
                                         Page:(NSString *)page
                                     CallBack:(ZRCommentCallBack)callback
{
    NSString *url = [HOST stringByAppendingString:zmyBusinessComment];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:screen forKey:@"screen"];
    [parameters setObject:rows forKey:@"rows"];
    [parameters setObject:page forKey:@"page"];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (callback) {
                callback(result[@"data"],nil);
            }
        }else{
            if (callback) {
                callback(result[@"message"],nil);
            }
        }
        
        
    } failure:^(id error) {
        if (callback) {
            callback(nil,error);
        }
    }];
    
}

@end
