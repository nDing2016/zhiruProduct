//
//  ZRUserShoppingCarRequest.m
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserShoppingCarRequest.h"
#import "ZRShoppingCarModel.h"
#import "ZRMarketModel.h"
@implementation ZRUserShoppingCarRequest

static NSString * const groupShoppingCar = @"user/myGroupShoppingCart";
static NSString * const deleteShoppingCar = @"group/deleteShoppingCart";
static NSString * const addShoppingCar = @"group/updateShoppingCart";
static NSString * const myKaShoppingCart = @"user/myKaShoppingCart";
static NSString * const delKaShoppingCart = @"ka/delKaShoppingCart";
static NSString * const addKaShoppingCart = @"ka/addKaShoppingCart";
static NSString * const subtractKaShoppingCart = @"ka/subtractKaShoppingCart";
static NSString * const shoppingCartAddKaOrder = @"ka/shoppingCartAddKaOrder";
/**
 * 用户购物车列表-团购购物车
 *
 * @param callBack 成功回调
 * @param failue   失败
 */
+ (void)groupShoppingCarCallBack:(void (^)(NSMutableArray *))callBack Failure:(void (^)(id))failure
{
    NSString * url = [HOST stringByAppendingString:groupShoppingCar];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
//        NSLog(@"团购====%@", result);
        NSMutableArray * array = [ZRShoppingCarModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        callBack(array);
    } failure:^(id error) {
        failure(error);
//        NSLog(@"error: %@", error);
    }];
}
/**
 * 团购购物车-删除团购
 * @param groupID       团购ID
 * @param businessID    店铺ID
 * @param callBack      成功
 * @param failue        失败
 */
+ (void)groupDeleteShoppingCarGroupID:(NSString *)groupID
                           BusinessID:(NSString *)businessID
                             CallBack:(void(^)(NSString * message))callBack
                              Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:deleteShoppingCar];
    
//    NSDictionary * param = @{@"rows":rows, @"page":page};
//    NSLog(@"%@ %@", groupID, businessID);
    NSDictionary * param = @{@"groupId":groupID, @"businessId":businessID};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        //NSLog(@"%@", message);
        callBack(message);
    } failure:^(id error) {
        //NSLog(@"%@", error);
        failure(error);
    }];
}
/**
 * 团购购物车-批量删除团购
 * @param list
 * @param callBack  成功
 * @param failure   失败
 */
+ (void)groupDeleteShoppingCarList:(NSMutableArray *)array
                          CallBack:(void(^)(NSString * message))callBack
                           Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:deleteShoppingCar];
    NSDictionary * param = @{@"list":array};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        //NSLog(@"%@", message);
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 团购购物车-修改(增减数量)
 * @param groupId       团购ID
 * @param num           当前数量
 * @param businessID    店铺ID
 * @param callBack      成功
 * @param failue        失败
 */
+ (void)groupAddShoppingCarGroupID:(NSString *)groupID
                            Number:(NSString *)num
                        BusinessID:(NSString *)businessID
                          CallBack:(void(^)(NSString * message))callBack
                           Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:addShoppingCar];
    NSDictionary * param = @{@"groupId":groupID,@"num":num,@"businessId":businessID};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        //NSLog(@"result: %@", dic);
        NSString * message = [dic objectForKey:@"message"];
        callBack(message);
        
    } failure:^(id error) {
        failure(error);
//        NSLog(@"result: %@", error);
    }];
}
/**
 * 超市购物车-列表
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)marketShoppingCarCallBack:(void(^)(NSMutableArray * array))callBack
                          Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:myKaShoppingCart];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        NSMutableArray * array = [ZRMarketModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        callBack(array);
//        NSLog(@"aaaaa====%@", result);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 超市购物车-从购物车删除
 * @param goodsId    物品Id
 * @param kaId       超市Id
 * @param callBack   成功
 * @param failure    失败
 */
+ (void)marketDeleteMarketGoodsId:(NSString *)goodsId
                             KaId:(NSString *)kaId
                         CallBack:(void(^)(NSString * message))callBack
                          Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:delKaShoppingCart];
    NSDictionary * param = @{@"goodsId":goodsId,@"kaId":kaId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
//        NSLog(@"----%@", result);
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
//        NSLog(@"++++%@", message);
        callBack(message);
    } failure:^(id error) {
        failure(error);
        
    }];
}
/**
 * 超市购物车-从购物车批量删除
 * @param list
 * @param callBack 成功
 * @param failure  失败
 */
+ (void)marketDeleteList:(NSMutableArray *)array
                CallBack:(void(^)(NSString * message))callBack
                 Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:delKaShoppingCart];
    NSDictionary * param = @{@"list":array};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
//        NSLog(@"----%@", result);
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
//        NSLog(@"++++%@", message);
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 超市购物车-添加物品
 * @param goodsId    物品Id
 * @param kaId       超市Id
 * @param callBack   成功
 * @param failure    失败
 */
+ (void)marketAddGoodsId:(NSString *)goodsId
                    KaId:(NSString *)kaId
                CallBack:(void(^)(NSString * message))callBack
                 Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:addKaShoppingCart];
    NSDictionary * param = @{@"goodsId":goodsId,@"kaId":kaId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        callBack(error);
    }];
}

/**
 * 超市购物车-减少物品
 * @param goodsId    物品Id
 * @param kaId       超市Id
 * @param callBack   成功
 * @param failure    失败
 */
+ (void)marketSubtractGoodsId:(NSString *)goodsId
                         KaId:(NSString *)kaId
                     CallBack:(void(^)(NSString * message))callBack
                      Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:subtractKaShoppingCart];
    NSDictionary * param = @{@"goodsId":goodsId,@"kaId":kaId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
//        NSLog(@"----%@", result);
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}

/**
 * 超市购物车提交订单
 * @param kaId            超市ID
 * @param kaName          超市名称
 * @param roomTips        重量费
 * @param sendPrice       配送费
 * @param taxation        税费
 * @param canadianDollar  总计
 * @param takeMealName    取餐人姓名
 * @param takeMealPhone   取餐人电话
 * @param remarks         备注
 * @param receiptAddress  收获地址id
 * @param kaOrderGoods    商品数组: [{goodsId:”物品id”,goodsName:”物品名称”,price:”当前物品总
 价”,(加币)num:”当前物品总数”}]
 * @param callBack        成功
 * @param failure         失败
 
 */
+ (void)shoppingCartAddKaOrderKaId:(NSString *)kaId
                            KaName:(NSString *)kaName
                          RoomTips:(NSString *)roomTips
                         SendPrice:(NSString *)sendPrice
                          Taxation:(NSString *)taxation
                    CanadianDollar:(NSString *)canadianDollar
                      TakeMealName:(NSString *)takeMealName
                     TakeMealPhone:(NSString *)takeMealPhone
                           Remarks:(NSString *)remarks
                    ReceiptAddress:(NSString *)receiptAddress
                      KaOrderGoods:(NSMutableArray *)kaOrderGoods
                          CallBack:(void(^)(id success))callBack
                            Filure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:shoppingCartAddKaOrder];
    NSDictionary * param = @{@"kaId":kaId, @"kaName":kaName, @"roomTips":roomTips, @"sendPrice":sendPrice, @"taxation":taxation, @"canadianDollar":canadianDollar, @"takeMealName":takeMealName, @"takeMealPhone":takeMealPhone,@"remarks":remarks,@"receiptAddress":receiptAddress,@"kaOrderGoods":kaOrderGoods};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        callBack(result);
    } failure:^(id error) {
        failure(error);
    }];
}
















@end
