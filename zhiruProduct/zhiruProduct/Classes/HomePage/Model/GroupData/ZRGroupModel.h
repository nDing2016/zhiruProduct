//
//  ZRGroupModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRGroupModel : NSObject
/**
 *  团购id
 */
@property (nonatomic , copy) NSString * groupId;
/**
 *  团购名称
 */
@property (nonatomic , copy) NSString * groupName;
/**
 *  图片地址
 */
@property (nonatomic , copy) NSString * groupImg;
/**
 *  地域名称
 */
@property (nonatomic , copy) NSString * regionName;
/**
 *  价格
 */
@property (nonatomic , copy) NSString * nowPrice;
/**
 *  距离
 */
@property (nonatomic , copy) NSString * distance;
/**
 *  店铺
 */
@property (nonatomic , copy) NSString * businessName;
@property (nonatomic , copy) NSString * businessId;
/**
 *  已售
 */
@property (nonatomic , copy) NSString * soldNum;
/**
 *  小吃,标签
 */
@property (nonatomic , copy) NSString * navName;


@end
