//
//  ZRUserStoreupRequest.m
//  zhiruProduct
//
//  Created by pj on 16/9/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserStoreupRequest.h"
#import "ZRBusinessModel.h"
#import "ZRGroupModel.h"
#import "ZROrderingBusinessMsg.h"
@implementation ZRUserStoreupRequest
static NSString * const businessCollection= @"user/businessCollection";
static NSString * const groupCollection = @"user/groupCollection";
static NSString * const orderingCollection = @"user/orderingCollection";
static NSString * const delBusinessCollection = @"collection/delBusinessCollection";
static NSString * const delGroupCollection = @"collection/delGroupCollection";
static NSString * const delOrderingCollection = @"collection/delOrderingCollection";


/**
 * 我的收藏-店铺接口
 * @param rows     条数
 * @param page     页数
 * @param callBack 成功回调
 * @param failure  失败
 */
+ (void)businessCCollectionWithRows:(NSString *)rows
                               Page:(NSString *)page
         BusinessCollectionCallBack:(void (^)(NSMutableArray * array, NSString * message))callBack
                            Failure:(void (^)(id))failure
{
    NSDictionary * paramDic = @{@"rows":rows,@"page":page};
    NSString * urlStr = [HOST stringByAppendingString:businessCollection];
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
//        NSLog(@"---%ld", [[result objectForKey:@"data"] count]);
        NSMutableArray * array = [NSMutableArray array];
        NSString * code = [result objectForKey:@"code"];
        NSString * message = [result objectForKey:@"message"];
        if ([code isEqualToString:@"S000"]) {
            array = [ZRBusinessModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"data"]];
            callBack(array, message);
        } else {
            callBack(array, message);
        }
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 我的收藏-团购接口
 * @param rows     条数
 * @param page     页数
 * @param callBack 成功回调
 * @param failure  失败
 */
+ (void)groupCollectionWithRows:(NSString *)rows
                           Page:(NSString *)page
        GroupCollectionCallBack:(void(^)(NSMutableArray * array, NSString * message))callBack
                        Failure:(void(^)(id error))failure;
{
    NSString * urlStr = [HOST stringByAppendingString:groupCollection];
    NSDictionary * paramDic = @{@"rows":rows,@"page":page};
    [ZRAFNRequests post:urlStr parameters:paramDic success:^(id result) {
//        NSLog(@"%@", result);
        NSString * code = [result objectForKey:@"code"];
        NSMutableArray * array = [NSMutableArray array];
        NSString * message = [result objectForKey:@"message"];
        if ([code isEqualToString:@"S000"]) {
            array = [ZRGroupModel mj_objectArrayWithKeyValuesArray:[result objectForKey:@"data"]];
            callBack(array, message);
        } else {
            callBack(array, message);
        }
    } failure:^(id error) {
//        NSLog(@"%@", error);
        failure(error);
    }];
}
/**
 * 我的收藏-订餐接口
 * @param rows      条数
 * @param page      页数
 * @param callBack  成功回调
 * @param failure   失败
 */
+ (void)orderingCollectionWithRows:(NSString *)rows
                              Page:(NSString *)page
        OrderingCollectionCallBack:(void(^)(NSMutableArray * array, NSString * message))callBack
                           Failure:(void(^)(id error))failure;
{
    NSString * urlStr = [HOST stringByAppendingString:orderingCollection];
    NSDictionary * param = @{@"rows":rows,@"page":page};
    [ZRAFNRequests post:urlStr parameters:param success:^(id result) {
        NSString * code = [result objectForKey:@"code"];
        NSString * message = [result objectForKey:@"message"];
        NSMutableArray * array = [NSMutableArray array];
        if ([code isEqualToString:@"S000"]) {
            NSArray * dataArray = result[@"data"];
            for (int i = 0; i < dataArray.count; i++) {
                ZROrderingBusinessMsg * model = [ZROrderingBusinessMsg mj_objectWithKeyValues:dataArray[i]];
                [array addObject:model];
            }
            
            callBack(array, message);
        } else {
            callBack(array , message);
        }
    } failure:^(id error) {
        
    }];
}
/**
 * 删除店铺收藏
 * @param businessId 店铺ID
 * @param callBack   message
 * @param failure    请求失败
 */
+ (void)delBusinessCollectionWithBusinessId:(NSString *)businessId
                                   CallBack:(void(^)(NSString * message))callBack
                                    Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:delBusinessCollection];
    NSDictionary * param = @{@"businessId":businessId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}
/**
 * 删除团购收藏
 * @param groupId    团购ID
 * @param businessId 店铺ID
 * @param callBack   message
 * @param failure    请求失败
 */
+ (void)delGroupCollectionWithGroupId:(NSString *)groupId
                           BusinessId:(NSString *)businessId
                             CallBack:(void(^)(NSString * message))callBack
                              Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:delGroupCollection];
    NSDictionary * param = @{@"businessId":businessId,@"groupId":groupId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}


/**
 * 删除订餐收藏
 * @param businessId 店铺ID
 * @param callBack   message
 * @param failure    请求失败
 */
+ (void)delOrderingCollectionWithBusinessId:(NSString *)businessId
                                   CallBack:(void(^)(NSString * message))callBack
                                    Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:delOrderingCollection];
    NSDictionary * param = @{@"businessId":businessId};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSDictionary * dic = result;
        NSString * message = [dic objectForKey:@"message"];
        callBack(message);
    } failure:^(id error) {
        failure(error);
    }];
}

@end
