//
//  ZRGroupBuyingDetailRequest.m
//  zhiruProduct
//
//  Created by nanding on 16/8/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyingDetailRequest.h"
#import "ZRRecommendListModel.h"
#import "ZRGroupBuyDetailModel.h"

static NSString * const zGroupBuyingList = @"group/list";

static NSString * const zGroupBuyingDetails = @"group/details";

@implementation ZRGroupBuyingDetailRequest

/**
 *  获取团购列表
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param regionId  地域
 *  @param label     标签
 *  @param sort      排序
 *  @param navId     大分类
 */
+(void)getGroupBuyingListWithParameters:(NSString *)longitude
                               Latitude:(NSString *)latitude
                               RegionId:(NSString *)regionId
                                  Label:(NSString *)label
                                   Sort:(NSString *)sort
                                  NavId:(NSString *)navId
                               Callback:(GroupListCallback)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:longitude forKey:@"longitude"];
    [parameters setObject:latitude forKey:@"latitude"];
    NSString *urlStr = [HOST stringByAppendingString:zGroupBuyingList];
    
    [ZRAFNRequests post:urlStr parameters:parameters success:^(id result) {
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
 *  获取团购详情
 *
 *  @param longitude  横坐标
 *  @param latitude   纵坐标
 *  @param groupId    团购id
 *  @param businessId 店铺id
 *  @param callback   回调
 */
+(void)getGroupBuyingDetailsWithLongitude:(NSString *)longitude
                                 Latitude:(NSString *)latitude
                                  GroupId:(NSString *)groupId
                               BusinessId:(NSString *)businessId
                                 Callback:(GroupDetailsCallback)callback
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:longitude forKey:@"longitude"];
    [parameters setObject:latitude forKey:@"latitude"];
    [parameters setObject:groupId forKey:@"groupId"];
    [parameters setObject:businessId forKey:@"businessId"];
    NSString *urlStr = [HOST stringByAppendingString:zGroupBuyingDetails];
    
    [ZRAFNRequests post:urlStr parameters:parameters success:^(id result) {
        if (result[@"data"]) {
            id res = result[@"data"];
            if (callback) {
                callback(res, nil);
            }
            
//            ZRGroupBuyDetailModel *model = [ZRGroupBuyDetailModel mj_objectWithKeyValues:res];
//            NSLog(@"model=====%@",model);
            
           
            
        }else{
            if (callback) {
                callback(nil, result[@"message"]);
            }
            
        }
        
        
    } failure:^(id error) {
        
        //NSLog(@"网络连接失败======%@",error);
        
    }];

}

@end
