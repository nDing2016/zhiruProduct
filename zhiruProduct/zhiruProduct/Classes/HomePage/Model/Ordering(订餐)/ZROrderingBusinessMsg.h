//
//  ZROrderingBusinessMsg.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZROrderingBusinessMsg : NSObject

/**
 *  店铺头像图片地址
 */
@property (nonatomic , copy) NSString * imgUrl;
/**
 * 优惠0不是1是
 */
@property (nonatomic , copy) NSString * preferential;
/**
 *  是否支持XX专送
 */
@property (nonatomic , copy) NSString * specialDelivery;
/**
 *  483.4km
 */
@property (nonatomic , copy) NSString * distance;
/**
 *  已售
 */
@property (nonatomic , copy) NSString * soldNum;
/**
 *  综合评价
 */
@property (nonatomic , copy) NSString * grade;
/**
 *  饭店1"
 */
@property (nonatomic , copy) NSString * name;
/**
 *  "店铺id"
 */
@property (nonatomic , copy) NSString * businessId;
/**
 *  起送价
 */
@property (nonatomic , copy) NSString * startingPrice;
/**
 *  是否支持在线支付0不支持1支持
 */
@property (nonatomic , copy) NSString * onlinePay;
/**
 *  是否支持 自提
 */
@property (nonatomic , copy) NSString * pickUp;
@end
