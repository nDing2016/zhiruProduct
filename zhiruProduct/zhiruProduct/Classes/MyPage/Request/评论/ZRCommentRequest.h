//
//  ZRCommentRequest.h
//  zhiruProduct
//
//  Created by nanding on 16/11/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ZRCommentCallBack)(id details, NSError *error);

@interface ZRCommentRequest : NSObject
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
                                     CallBack:(ZRCommentCallBack)callback;




/**
 *  店铺评论－删除评论
 *
 *  @param commentId 评论id
 *  @param callback  回调
 */
+ (void)requestForBusinessCommentDeleteWithCommentId:(NSString *)commentId
                                            CallBack:(ZRCommentCallBack)callback;




/**
 *  店铺评论－评论详情接口
 *
 *  @param commentId 评论ID
 *  @param callback  回调
 */
+ (void)requestForBusinessCommentDetailsWithCommentId:(NSString *)commentId
                                             CallBack:(ZRCommentCallBack)callback;

@end
