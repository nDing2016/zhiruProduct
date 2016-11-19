//
//  ZROrderingOrderRequest.m
//  zhiruProduct
//
//  Created by pj on 16/10/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingOrderRequest.h"
#import "ZRLunchModel.h"
#import "ZRSuperOderModel.h"
#import "ZRLunchOrderDetailModel.h"
#import "ZRSuperDetailsModel.h"
#import "ZRAddKaOrderModel.h"


@implementation ZROrderingOrderRequest

static NSString * const addComment = @"ordering/addComment";
static NSString * const myLunchOrder = @"lunch/myLunchOrder";
static NSString * const myKaOrder = @"ka/myKaOrder";
static NSString * const myLunchOrderDetails = @"lunch/myLunchOrderDetails";
static NSString * const myKaOrderDetails = @"ka/myKaOrderDetails";
static NSString * const createSignOrderUrl = @"lunch/createSignOrderUrl";
static NSString * const cancelOrder = @"lunch/cancelOrder";
static NSString * const kaCancelOrder = @"ka/cancelOrder";
static NSString * const deleteLunchOrder = @"lunch/deleteOrder";
static NSString * const kaCreateSignOrderUrl = @"ka/createSignOrderUrl";
/**
 * 添加订餐评论
 * @param businessId: 商户Id
 * @param content:    评论内容
 * @param grade:      总体评价
 * @param gradeOne:   口味5个等级
 * @param gradetwo:   服务5个等级
 * @param commentImgList: [{fileName ：”xxxxxxx”，imageData:”流”}]
 * @param callBack:   成功
 * @param failure:    失败
 */
+ (void)orderingCommentWithBusinessId:(NSString *)businessId
                              Content:(NSString *)content
                                Grade:(NSString *)grade
                             GradeOne:(NSString *)gradeOne
                             GradeTwo:(NSString *)gradeTwo
                       CommentImgList:(NSArray *)commentImgList
                             CallBack:(void(^)(id success))callBack
                              Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:addComment];
    NSDictionary * param = @{@"businessId":businessId,@"content":content,@"grade":grade,@"gradeOne":gradeOne,@"gradeTwo":gradeTwo};
    [ZRAFNRequests post:url parameters:param imageFile:commentImgList fileKey:@"commentImgList" success:^(id result) {
        callBack(result[@"message"]);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 * 我的午餐订单
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)myLunchOrderWithCallBack:(void(^)(id success))callBack
                         Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:myLunchOrder];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        NSDictionary * dic = result;
        NSArray * dataArray = dic[@"data"];
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i++) {
            ZRLunchModel * model = [ZRLunchModel mj_objectWithKeyValues:dataArray[i]];
            [array addObject:model];
        }
        callBack(array);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 我的午餐订单详情
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)myLunchOrderDetailsWithOrderId:(NSString *)orderId
                              CallBack:(void(^)(id success))callBack
                               Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:myLunchOrderDetails];
    NSDictionary * param = @{@"orderId":orderId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
//        NSLog(@"^^^^^%@", result);
        NSDictionary * dic = result;
        NSDictionary * data = dic[@"data"];
        ZRLunchOrderDetailModel * deatilModel = [ZRLunchOrderDetailModel mj_objectWithKeyValues:data];
        callBack(deatilModel);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 午餐删除订单
 * @param orderId:  订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)deleteLunchOrderWithOrderId:(NSString *)orderId
                           CallBack:(void(^)(id success))callBack
                            Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:deleteLunchOrder];
    NSDictionary * param = @{@"orderId":orderId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSLog(@"删除订单: %@", result);
        NSDictionary * dict = result;
        callBack(dict[@"message"]);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 我的超市订单
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)myKaOrderWithCallBack:(void(^)(id success))callBack
                      Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:myKaOrder];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        NSDictionary * dic = result;
        NSArray * dataArray = dic[@"data"];
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i++) {
            ZRSuperOderModel * model = [ZRSuperOderModel mj_objectWithKeyValues:dataArray[i]];
            [array addObject:model];
        }
        callBack(array);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 我的超市订单详情
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure: 失败
 */
+ (void)myKaOrderDetailsWithOrderId:(NSString *)orderId
                           CallBack:(void(^)(id success))callBack
                            Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:myKaOrderDetails];
    NSDictionary * param = @{@"orderId":orderId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSDictionary * data = dic[@"data"];
        ZRSuperDetailsModel * model = [ZRSuperDetailsModel mj_objectWithKeyValues:data];
        callBack(model);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 午餐生成订单支付码
 * @param orderId:  订单号
 * @param total:    总价
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)createSignOrderUrlWithOrderId:(NSString *)orderId
                                Total:(NSString *)total
                             CallBack:(void(^)(id success))callBack
                              Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:createSignOrderUrl];
    NSDictionary * param = @{@"orderId":orderId,@"total":total};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSDictionary * data = dict[@"data"];
        ZRAddKaOrderModel * model = [ZRAddKaOrderModel mj_objectWithKeyValues:data];
        callBack(model);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 超市生成订单支付码
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)kaCreateSignOrderUrlWithOrderId:(NSString *)orederId
                               CallBack:(void(^)(id success))callBack
                                Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:kaCreateSignOrderUrl];
    NSDictionary * param = @{@"orderId":orederId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSDictionary * data = dict[@"data"];
        ZRAddKaOrderModel * model = [ZRAddKaOrderModel mj_objectWithKeyValues:data];
        callBack(model);
    } failure:^(id error) {
        failure(error);
    }];
}

/**
 * 午餐取消订单
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure: 失败
 */
+ (void)cancelOrderWithOrderId:(NSString *)orderId
                      CallBack:(void(^)(id success))callBack
                       Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:cancelOrder];
    NSDictionary * param = @{@"orderId":orderId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSString * message = dict[@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 超市取消订单
 * @param orderId: 订单号
 * @param callBack: 成功
 * @param failure:  失败
 */
+ (void)kaCanacelOrderWithOrderId:(NSString *)orderId
                         CallBack:(void(^)(id success))callBack
                          Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:kaCancelOrder];
    NSDictionary * param = @{@"orderId":orderId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dict = result;
        NSString * message = dict[@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}

@end
