//
//  ZRPayOrderRequest.h
//  zhiruProduct
//
//  Created by nanding on 16/10/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZRPayOrderCallback) (id details, NSError *error);

@interface ZRPayOrderRequest : NSObject
///**
// *  添加订单接口
// *
// *  @param sendTime        送达时间
// *  @param price           小费
// *  @param taxation        税费
// *  @param canadianDollar           总计
// *  @param receiptAddress  收货地址
// *  @param payMethod       支付方式
// *  @param remarks         备注
// *  @param LunchOrderGoods 午餐订单货品
// *  @param callback        回调
// */
//+(void)requestForAddLunchOrderWithSendTime:(NSString *)sendTime
//                                     Price:(NSString *)price
//                                  Taxation:(NSString *)taxation
//                            CanadianDollar:(NSString *)canadianDollar
//                            ReceiptAddress:(NSString *)receiptAddress
//                                 PayMethod:(NSString *)payMethod
//                                   Remarks:(NSString *)remarks
//                           LunchOrderGoods:(NSMutableDictionary *)LunchOrderGoods
//                                  CallBack:(ZRPayOrderCallback)callback;




/**
 *  午餐－付费完成
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */
+ (void)requestForLunchEvaluateOrderWithOrderId:(NSString *)orderId
                                       CallBack:(ZRPayOrderCallback)callback;




/**
 *  超市－付费完成
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */
+ (void)requestForKaEvaluateKaOrderWithOrderId:(NSString *)orderId
                                      CallBack:(ZRPayOrderCallback)callback;




/**
 *  获取汇率
 *
 *  @param callback 回调
 */
+ (void)requestForVersionGetRateWithCallBack:(ZRPayOrderCallback)callback;







/**
 *  积分兑换
 *
 *  @param points         积分
 *  @param commodityName  兑换商品名
 *  @param commodityId    商品ID
 *  @param receiptAddress 收货地址
 *  @param receiptName    收货姓名
 *  @param receiptPhone   收货手机
 *  @param gender         性别
 *  @param num            数量
 *  @param callback       回调
 */
+ (void)requestForPointsExchangeWithPoints:(NSString *)points
                             CommodityName:(NSString *)commodityName
                               CommodityId:(NSString *)commodityId
                            ReceiptAddress:(NSString *)receiptAddress
                               ReceiptName:(NSString *)receiptName
                              ReceiptPhone:(NSString *)receiptPhone
                                    Gender:(NSString *)gender
                                       Num:(NSString *)num
                                  CallBack:(ZRPayOrderCallback)callback;


@end
