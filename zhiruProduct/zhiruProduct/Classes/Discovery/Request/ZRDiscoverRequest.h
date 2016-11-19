//
//  ZRDiscoverRequest.h
//  zhiruProduct
//
//  Created by nanding on 16/8/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DiscoverCallBack) (id details, NSError *error);

@interface ZRDiscoverRequest : NSObject

/**
 *  推荐请求接口
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param callback  回调
 */
+(void)requestForRecommentWithLongitude:(NSString *)longitude
                           WithLatitude:(NSString *)latitude
                           WithCallback:(DiscoverCallBack)callback;



/**
 *  新品请求接口
*/
+(void)requestForNewProdectWithLongitude:(NSString *)longitude
                            WithLatitude:(NSString *)latitude
                            WithCallback:(DiscoverCallBack)callback;


/**
 *  积分商城接口
 *
 *  @param rows     条数
 *  @param page     页数
 *  @param callback 回调
 */
+(void)requestForIntegralMallWithRows:(NSString *)rows
                             WithPage:(NSString *)page
                         WithCallback:(DiscoverCallBack)callback;


/**
 *  积分兑换接口
 *
 *  @param points        积分
 *  @param commodityName 要兑换的商品名
 *  @param commodityId   要兑换的商品ID
 *  @param callback      回调
 */
+(void)requestForExchangePointsWithPoints:(NSString *)points
                        WithCommodityName:(NSString *)commodityName
                          WithCommodityId:(NSString *)commodityId
                             WithCallback:(DiscoverCallBack)callback;


/**
 *  积分商城中物品详情接口
 *
 *  @param commodityId 物品ID
 *  @param callback    回调
 */
+(void)requestForIntegralMallProductDetailsWithCommodityId:(NSString *)commodityId
                                              WithCallback:(DiscoverCallBack)callback;


@end
