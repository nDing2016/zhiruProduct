//
//  ZRSupermarketRequest.h
//  zhiruProduct
//
//  Created by nanding on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SupermarketHomeCallback) (id details, NSError *error);

typedef void(^SupermarketProductsListCallback) (id details, NSError *error);

typedef void(^SupermarketAddShoppingCarCallback) (NSString *codeStr ,NSString *message, NSError *error);

@interface ZRSupermarketRequest : NSObject
/**
 *  首页
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param callback  回调
 */
+(void)requestSupermarketHomePageWithLogitude:(NSString *)longitude
                                 WithLatitude:(NSString *)latitude
                                     Callback:(SupermarketHomeCallback)callback;



/**
 *  超市商品列表页面
 *
 *  @param kaId     超市ID
 *  @param callback 回掉
 */
+(void)requestSupermarketProductsListWithSuperId:(NSString *)kaId
                                        Callback:(SupermarketProductsListCallback)callback;



/**
 *  从购物车中添加
 *
 *  @param goodsId  物品id
 *  @param kaId     超市id
 *  @param callback 回调
 */
+(void)requestAddToShoppingCarWithGoodsId:(NSString *)goodsId
                        WithSupermarketId:(NSString *)kaId
                                 Callback:(SupermarketAddShoppingCarCallback)callback;




/**
 *  提交订单
 *
 *  @param kaId           超市id
 *  @param kaName         超市名称
 *  @param roomTips       重量费
 *  @param sendPrice      配送费
 *  @param taxation       税费
 *  @param canadianDollar          总计
 *  @param remarks        备注
 *  @param receiptAddress 收货地址id
 *  @param kaOrderGoods   数组
 *  @param takeMealName   取餐人姓名
 *  @param takeMealPhone  取餐人电话
 *  @param callback       回调
 */
+(void)requestAddKaOrderWithKaId:(NSString *)kaId
                          KaName:(NSString *)kaName
                        RoomTips:(NSString *)roomTips
                       SendPrice:(NSString *)sendPrice
                        Taxation:(NSString *)taxation
                  CanadianDollar:(NSString *)canadianDollar
                         Remarks:(NSString *)remarks
                  ReceiptAddress:(NSString *)receiptAddress
                    KaOrderGoods:(NSArray *)kaOrderGoods
                    TakeMealName:(NSString *)takeMealName
                   TakeMealPhone:(NSString *)takeMealPhone
                        Callback:(SupermarketHomeCallback)callback;





/**
 *  添加到购物车
 *
 *  @param list     添加到购物车的商品数组
 *  @param callback 回调
 */
+(void)requestAddKaShoppingCartWithList:(NSArray *)list
                               Callback:(SupermarketAddShoppingCarCallback)callback;



/**
 *  查询特殊天气
 *
 *  @param success 成功
 *  @param failure 失败
 */
+(void)requestWeatherandSuccess: (void(^)(id success))success
                     andFailure:(void(^)(id error))failure;


/**
 *  获取距离
 *
 *  @param longitudeOne 超市坐标
 *  @param latitudeOne  超市坐标
 *  @param longitudeTwo 用户坐标
 *  @param latitudeTwo  用户坐标
 *  @param success      成功
 *  @param failure      失败
 */
+(void)requestGetDustabceWithLongitudeOne:(NSString *)longitudeOne
                           andLatitudeOne:(NSString *)latitudeOne
                          andLongitudeTwo:(NSString *)longitudeTwo
                          andLatitudeTwo :(NSString *)latitudeTwo
                               andSuccess: (void(^)(id success))success
                               andFailure:(void(^)(id error))failure;
@end
