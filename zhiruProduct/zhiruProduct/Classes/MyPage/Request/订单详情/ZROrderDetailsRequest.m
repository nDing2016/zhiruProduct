//
//  ZROrderDetailsRequest.m
//  zhiruProduct
//
//  Created by nanding on 16/10/20.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderDetailsRequest.h"

static NSString * const zMyKaOrderDetails= @"ka/myKaOrderDetails";

//超市订单流程
static NSString * const zOrderProcess= @"ka/kaOrderProcess";

//超市删除订单
static NSString * const zDeleteOrder= @"ka/deleteOrder";

@implementation ZROrderDetailsRequest


/**
 *  我的超市订单详情
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */
+(void)requestForMyKaOrderDetailsWithOrderId:(NSString *)orderId
                                    Callback:(OrderDetailsCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zMyKaOrderDetails];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:orderId forKey:@"orderId"];
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (result[@"data"]) {
                if (callback) {
                    callback(result[@"data"],nil);
                }
            }
        }
        
        
    } failure:^(id error) {
        if (callback) {
            callback(nil, error);
        }
        
    }];
    
}


/**
 *   超市订单流程
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */
+(void)requestForKaOrderProcessWithOrderId:(NSString *)orderId
                                  Callback:(OrderDetailsCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zOrderProcess];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:orderId forKey:@"orderId"];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (callback) {
                callback(result[@"data"],nil);
            }
        }
        
        
    } failure:^(id error) {
        if (callback) {
            callback(nil,error);
        }
        
    }];
    
    
    
}




/**
 *  超市删除订单
 *
 *  @param orderId  订单号
 *  @param callback 回调
 */

+(void)requestForKaDeleteOrderWithOrderId:(NSString *)orderId
                                 Callback:(OrderDetailsCallback)callback
{
    NSString *url = [HOST stringByAppendingString:zDeleteOrder];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:orderId forKey:@"orderId"];
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        
        if ([result[@"code"] isEqualToString:@"S000"]) {
            if (callback) {
                callback(result, nil);
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
            [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
        }
        
    } failure:^(id error) {
        
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
        [SVProgressHUD performSelector:@selector(dismiss) withObject:nil afterDelay:2];
        
    }];
    
}


@end
