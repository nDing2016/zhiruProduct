//
//  ZRDiscoverRequest.m
//  zhiruProduct
//
//  Created by nanding on 16/8/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRDiscoverRequest.h"

//推荐
static NSString * const zRecomment = @"group/recommend";
//新品
static NSString * const zNewProduct = @"group/recommendNewGroup";
//积分商城
static NSString * const zIntegralMall = @"points/list";

//积分兑换
static NSString * const zExchangePoints = @"points/exchange";

//积分商城中物品详情
static NSString * const zProductDetail = @"points/detailsHtml";


@implementation ZRDiscoverRequest

/**
 *  推荐请求接口
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param callback  回调
 */
+(void)requestForRecommentWithLongitude:(NSString *)longitude
                           WithLatitude:(NSString *)latitude
                           WithCallback:(DiscoverCallBack)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:longitude forKey:@"longitude"];
    [parameters setObject:latitude forKey:@"latitude"];
    
    NSString *url = [HOST stringByAppendingString:zRecomment];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if (result[@"data"]) {
            
            if (callback) {
                callback(result[@"data"], nil);
            }
            
        }else{
            if (callback) {
                callback(nil, result[@"message"]);
            }
        }
        
        
    } failure:^(id error) {
        
    }];

    
    
}



/**
 *  新品请求接口
 */
+(void)requestForNewProdectWithLongitude:(NSString *)longitude
                            WithLatitude:(NSString *)latitude
                            WithCallback:(DiscoverCallBack)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:longitude forKey:@"longitude"];
    [parameters setObject:latitude forKey:@"latitude"];
    
    NSString *url = [HOST stringByAppendingString:zNewProduct];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if (result[@"data"]) {
            
            if (callback) {
                callback(result[@"data"], nil);
            }
            
        }else{
            if (callback) {
                callback(nil, result[@"message"]);
            }
        }
        
        
    } failure:^(id error) {
        
    }];

    
}



/**
 *  积分商城接口
 *
 *  @param rows     条数
 *  @param page     页数
 *  @param callback 回调
 */
+(void)requestForIntegralMallWithRows:(NSString *)rows
                             WithPage:(NSString *)page
                         WithCallback:(DiscoverCallBack)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:rows forKey:@"rows"];
    [parameters setObject:page forKey:@"page"];
    
    NSString *url = [HOST stringByAppendingString:zIntegralMall];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if (result[@"data"]) {
            
            if (callback) {
                callback(result[@"data"], nil);
            }
            
        }else{
            if (callback) {
                callback(nil, result[@"message"]);
            }
        }
        
        
    } failure:^(id error) {
        
    }];

}


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
                             WithCallback:(DiscoverCallBack)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:points forKey:@"points"];
    [parameters setObject:commodityName forKey:@"commodityName"];
    [parameters setObject:commodityId forKey:@"commodityId"];
    
    NSString *url = [HOST stringByAppendingString:zExchangePoints];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if (result[@"message"]) {
            
            if (callback) {
                callback(result[@"message"], nil);
            }
            
        }else{
            if (callback) {
                callback(nil, result[@"message"]);
            }
        }
        
        
    } failure:^(id error) {
        
    }];

}


/**
 *  积分商城中物品详情接口
 *
 *  @param commodityId 物品ID
 *  @param callback    回调
 */
+(void)requestForIntegralMallProductDetailsWithCommodityId:(NSString *)commodityId
                                              WithCallback:(DiscoverCallBack)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:commodityId forKey:@"commodityId"];
    
    NSString *url = [HOST stringByAppendingString:zProductDetail];
    
    [ZRAFNRequests post:url parameters:parameters success:^(id result) {
        if (result[@"data"]) {
            
            if (callback) {
                callback(result[@"data"], nil);
            }
            
        }else{
            if (callback) {
                callback(nil, result[@"message"]);
            }
        }
        
        
    } failure:^(id error) {
        
        
        
    }];

}


@end
