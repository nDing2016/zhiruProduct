//
//  ZRUserPointsRequest.m
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserPointsRequest.h"
#import "ZRPointsModel.h"
#import "ZRExchangeModel.h"
@implementation ZRUserPointsRequest

static NSString * const personalPoints = @"points/PersonalPoints";
static NSString * const pointsExchange = @"points/PointsExchange";
/**
 * 用户积分列表-积分明细
 * @param rows: 条数
 * @param page: 页数
 */
+ (void)personPointsRows:(NSString *)rows
                    page:(NSString *)page
                CallBack:(void(^)(NSMutableArray * array))callBack
                 Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:personalPoints];
    NSDictionary * param = @{@"rows":rows, @"page":page};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
//        NSLog(@"%@", result);
        NSMutableArray * array = [NSMutableArray array];
        ZRPointsModel * model = [ZRPointsModel mj_objectWithKeyValues:result[@"data"]];
        [array addObject:model];
        callBack(array);
        
    } failure:^(id error) {
        
        
    }];
}
/**
 * 用户积分列表-积分兑换
 * @param rows: 条数
 * @param page: 页数
 */
+ (void)pointExchangeRows:(NSString *)rows
                     Page:(NSString *)page
                 CallBack:(void(^)(NSMutableArray * array))callBack
                  Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:pointsExchange];
    NSDictionary * param = @{@"rows":rows, @"page":page};
    [ZRAFNRequests post:url parameters:param success:^(id result) {
        NSMutableArray * array = [NSMutableArray array];
        ZRExchangeModel * model = [ZRExchangeModel mj_objectWithKeyValues:result[@"data"]];
        [array addObject:model];
        callBack(array);
        
    } failure:^(id error) {
        failure(error);
        
    }];
}
@end