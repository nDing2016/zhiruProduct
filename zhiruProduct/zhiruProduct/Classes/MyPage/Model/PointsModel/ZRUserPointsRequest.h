//
//  ZRUserPointsRequest.h
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRUserPointsRequest : NSObject


/**
 * 用户积分列表-积分明细
 * @param rows: 条数
 * @param page: 页数
 */
+ (void)personPointsRows:(NSString *)rows
                    page:(NSString *)page
                CallBack:(void(^)(NSMutableArray * array))callBack
                 Failure:(void(^)(id error))failure;
/**
 * 用户积分列表-积分兑换
 * @param rows: 条数
 * @param page: 页数
 */
+ (void)pointExchangeRows:(NSString *)rows
                     Page:(NSString *)page
                 CallBack:(void(^)(NSMutableArray * array))callBack
                  Failure:(void(^)(id error))failure;

/**
 * 积分订单详情
 * @param orderId: 订单Id
 * @param callBack: 成功
 * @param failure: 失败
 */
+ (void)pointDetailOrderId:(NSString *)orderId
                  CallBack:(void(^)(id result))callBack
                   Failure:(void(^)(id error))failure;
@end
