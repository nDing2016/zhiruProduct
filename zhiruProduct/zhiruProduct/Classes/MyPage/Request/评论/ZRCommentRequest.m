//
//  ZRCommentRequest.m
//  zhiruProduct
//
//  Created by nanding on 16/11/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRCommentRequest.h"

static NSString * const zmyBusinessComment= @"user/myBusinessComment";
static NSString * const zbusinessCommentDelete= @"businessComment/delete";
static NSString * const zbusinessCommentDetails= @"businessComment/details";


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
//        if ([result[@"code"] isEqualToString:@"S000"]) {
//            if (callback) {
//                callback(result[@"data"],nil);
//            }
//        }else{
//            if (callback) {
//                callback(result[@"code"],nil);
//            }
//        }
        
        if (callback) {
            callback(result,nil);
        }
        
        
    } failure:^(id error) {
        if (callback) {
            callback(nil,error);
        }
    }];
    
}






/**
 *  店铺评论－删除评论
 *
 *  @param commentId 评论id
 *  @param callback  回调
 */
+ (void)requestForBusinessCommentDeleteWithCommentId:(NSString *)commentId
                                            CallBack:(ZRCommentCallBack)callback
{
    NSString *url = [HOST stringByAppendingString:zbusinessCommentDelete];
    [ZRAFNRequests post:url parameters:@{@"commentId":commentId} success:^(id result) {
        
        if (callback) {
            callback(result, nil);
        }
        
    } failure:^(id error) {
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
        
    }];
}



/**
 *  店铺评论－评论详情接口
 *
 *  @param commentId 评论ID
 *  @param callback  回调
 */
+ (void)requestForBusinessCommentDetailsWithCommentId:(NSString *)commentId
                                             CallBack:(ZRCommentCallBack)callback
{
    NSString *url = [HOST stringByAppendingString:zbusinessCommentDetails];
    [ZRAFNRequests post:url parameters:@{@"commentId":commentId} success:^(id result) {
        
        if (callback) {
            callback(result,nil);
        }
        
        
    } failure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"网络出问题了"];
        [SVProgressHUD performSelector:@selector(dismiss)withObject:nil afterDelay:2];
        
    }];
}


@end
