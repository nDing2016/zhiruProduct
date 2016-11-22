//
//  ZRUserStoreupRequest.h
//  zhiruProduct
//
//  Created by pj on 16/9/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZRUserStoreupRequest : NSObject

/**
 * 我的收藏-店铺接口
 * @param rows     条数
 * @param page     页数
 * @param callBack 成功回调
 * @param failure  失败
 */
+ (void)businessCCollectionWithRows:(NSString *)rows
                               Page:(NSString *)page
         BusinessCollectionCallBack:(void(^)(NSMutableArray * array, NSString * message))callBack
                            Failure:(void(^)(id error))failure;
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

/**
 * 删除店铺收藏
 * @param businessId 店铺ID
 * @param callBack   message
 * @param failure    请求失败
 */
+ (void)delBusinessCollectionWithBusinessId:(NSString *)businessId
                                   CallBack:(void(^)(NSString * message))callBack
                                    Failure:(void(^)(id error))failure;
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
                              Failure:(void(^)(id error))failure;


/**
 * 删除订餐收藏
 * @param businessId 店铺ID
 * @param callBack   message
 * @param failure    请求失败
 */
+ (void)delOrderingCollectionWithBusinessId:(NSString *)businessId
                                   CallBack:(void(^)(NSString * message))callBack
                                    Failure:(void(^)(id error))failure;













@end
