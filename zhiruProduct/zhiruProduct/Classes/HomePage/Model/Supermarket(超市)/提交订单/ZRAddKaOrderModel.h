//
//  ZRAddKaOrderModel.h
//  zhiruProduct
//
//  Created by nanding on 16/10/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRAddKaOrderModel : NSObject

//订单号
@property (nonatomic, copy) NSString *orderId;

//价钱
@property (nonatomic, copy) NSString *price;

//支付宝支付需要加密码
@property (nonatomic, copy) NSString *signOrderUrl;

//微信支付需要加密码
@property (nonatomic, copy) NSString *wechatSignOrderUrl;

//paypal支付需要加密码
@property (nonatomic, copy) NSString *paypalSignOrderUrl;

@end
