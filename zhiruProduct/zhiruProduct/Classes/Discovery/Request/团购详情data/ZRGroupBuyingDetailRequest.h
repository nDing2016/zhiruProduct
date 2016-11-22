//
//  ZRGroupBuyingDetailRequest.h
//  zhiruProduct
//
//  Created by nanding on 16/8/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GroupListCallback) (NSArray *groupLists,NSError *error);

typedef void(^GroupDetailsCallback) (id details, NSError *error);

@interface ZRGroupBuyingDetailRequest : NSObject
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
                               Callback:(GroupListCallback)callback;


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
                                 Callback:(GroupDetailsCallback)callback;





@end
