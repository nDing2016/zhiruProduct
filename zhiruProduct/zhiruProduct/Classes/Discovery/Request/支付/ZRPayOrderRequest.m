//
//  ZRPayOrderRequest.m
//  zhiruProduct
//
//  Created by nanding on 16/10/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPayOrderRequest.h"


//添加订单
//static NSString * const zAddLunchOrder = @"lunch/addLunchOrder";

//午餐付费完成
static NSString * const zLunchPayFinished = @"lunch/evaluateOrder";

//超市付费完成
static NSString * const zSupermarketPayFinished = @"ka/evaluateKaOrder";

//获取汇率
static NSString * const zVersionGetRate = @"version/getRate";

//积分兑换
static NSString * const zExchangePoints = @"points/exchange";

@implementation ZRPayOrderRequest

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
//                                  CallBack:(ZRPayOrderCallback)callback
//{
//    NSString *url = [HOST stringByAppendingString:zAddLunchOrder];
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    [parameters setObject:sendTime forKey:@"sendTime"];
//    [parameters setObject:price forKey:@"price"];
//    [parameters setObject:taxation forKey:@"taxation"];
//    [parameters setObject:canadianDollar forKey:@"canadianDollar"];
//    [parameters setObject:receiptAddress forKey:@"receiptAddress"];
//    [parameters setObject:payMethod forKey:@"payMethod"];
//    [parameters setObject:remarks forKey:@"remarks"];
//    [parameters setObject:LunchOrderGoods forKey:@"LunchOrderGoods"];
//    
//    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
//        
//        
//        
//        
//    } failure:^(id error) {
//        
//    }];
//    
//    
//}
//



/**
 *  午餐－付费完成
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */
+ (void)requestForLunchEvaluateOrderWithOrderId:(NSString *)orderId
                                       CallBack:(ZRPayOrderCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zLunchPayFinished];
    [ZRAFNRequests post:url parameters:@{@"orderId":orderId} success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if ([result[@"message"] isEqualToString:@"success"]) {
                if (callback) {
                    callback(result[@"message"],nil);
                }
            }
        }
        
        
    } failure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"网络出现问题..."];
    }];
}



/**
 *  超市－付费完成
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */
+ (void)requestForKaEvaluateKaOrderWithOrderId:(NSString *)orderId
                                      CallBack:(ZRPayOrderCallback)callback
{
   
    NSString *url = [HOST stringByAppendingString:zSupermarketPayFinished];
    [ZRAFNRequests post:url parameters:@{@"orderId":orderId} success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if ([result[@"message"] isEqualToString:@"success"]) {
                //[SVProgressHUD showSuccessWithStatus:@"付费完成"];
                if (callback) {
                    callback(result[@"message"],nil);
                }
                
            }
        }
        
        
    } failure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"网络出现问题..."];
    }];

}


/**
 *  获取汇率
 *
 *  @param callback 回调
 */
+ (void)requestForVersionGetRateWithCallBack:(ZRPayOrderCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zVersionGetRate];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        if (result[@"rate"]) {
            if (callback) {
                callback(result,nil);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"获取汇率出错请稍候再试"];
        }
        
    } failure:^(id error) {
        if (callback) {
            callback(nil,error);
        }
        
    }];
}






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
                                  CallBack:(ZRPayOrderCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zExchangePoints];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:points forKey:@"points"];
    [parameters setObject:commodityName forKey:@"commodityName"];
    [parameters setObject:commodityId forKey:@"commodityId"];
    [parameters setObject:receiptAddress forKey:@"receiptAddress"];
    [parameters setObject:receiptName forKey:@"receiptName"];
    [parameters setObject:receiptPhone forKey:@"receiptPhone"];
    [parameters setObject:gender forKey:@"gender"];
    [parameters setObject:num forKey:@"num"];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (callback) {
                callback(result, nil);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"兑换失败"];
            
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
            
        }
        
        
    } failure:^(id error) {
        [SVProgressHUD showErrorWithStatus:@"由于网络问题，兑换失败"];
        
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    }];
    
    
}



@end
