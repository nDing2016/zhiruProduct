//
//  ZROrderingOrderRequest.h
//  zhiruProduct
//
//  Created by pj on 16/10/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZROrderingOrderRequest : NSObject


/**
 * 添加订餐评论
 * @param businessId: 商户Id
 * @param content:    评论内容
 * @param grade:      总体评价
 * @param gradeOne:   口味5个等级
 * @param gradetwo:   服务5个等级
 * @param commentImgList: [{fileName ：”xxxxxxx”，imageData:”流”}]
 * @param callBack:   成功
 * @param failure:    失败
 */
+ (void)orderingCommentWithBusinessId:(NSString *)businessId
                              Content:(NSString *)content
                                Grade:(NSString *)grade
                             GradeOne:(NSString *)gradeOne
                             GradeTwo:(NSString *)gradeTwo
                       CommentImgList:(NSArray *)commentImgList
                             CallBack:(void(^)(id success))callBack
                              Failure:(void(^)(id error))failure;

/**
 * 我的午餐订单列表
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)myLunchOrderWithCallBack:(void(^)(id success))callBack
                         Failure:(void(^)(id error))failure;

/**
 * 我的午餐订单详情
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)myLunchOrderDetailsWithOrderId:(NSString *)orderId
                              CallBack:(void(^)(id success))callBack
                               Failure:(void(^)(id error))failure;
/**
 * 午餐删除订单
 * @param orderId:  订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)deleteLunchOrderWithOrderId:(NSString *)orderId
                           CallBack:(void(^)(id success))callBack
                            Failure:(void(^)(id error))failure;
/**
 * 我的超市订单
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)myKaOrderWithCallBack:(void(^)(id success))callBack
                      Failure:(void(^)(id error))failure;

/**
 * 我的超市订单详情
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure: 失败
 */
//+ (void)myKaOrderDetailsWithOrderId:(NSString *)orderId
//                           CallBack:(void(^)(id success))callBack
//                            Failure:(void(^)(id error))failure;

/**
 * 午餐生成订单支付码
 * @param orderId:  订单号
 * @param total:    总价
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)createSignOrderUrlWithOrderId:(NSString *)orderId
                                Total:(NSString *)total
                             CallBack:(void(^)(id success))callBack
                              Failure:(void(^)(id error))failure;
/**
 * 超市生成订单支付码
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)kaCreateSignOrderUrlWithOrderId:(NSString *)orederId
                               CallBack:(void(^)(id success))callBack
                                Failure:(void(^)(id error))failure;
/**
 * 午餐取消订单
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure: 失败
 */
+ (void)cancelOrderWithOrderId:(NSString *)orderId
                      CallBack:(void(^)(id success))callBack
                       Failure:(void(^)(id error))failure;
/**
 * 超市取消订单
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)kaCanacelOrderWithOrderId:(NSString *)orderId
                         CallBack:(void(^)(id success))callBack
                          Failure:(void(^)(id error))failure;
@end
