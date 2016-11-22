//
//  ZRSuperOderModel.h
//  zhiruProduct
//
//  Created by pj on 16/10/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRSuperOderModel : NSObject

@property (nonatomic, copy)NSString * canadianDollar;//总价

@property (nonatomic, copy)NSString * orderId; // 订单Id

@property (nonatomic, copy)NSString * kaName; // 超市名称

@property (nonatomic, copy)NSString * kaId; // 超市Id

@property (nonatomic, copy)NSString * updateTime; // 下单时间

@property (nonatomic, strong)NSArray * list;

@property (nonatomic, copy)NSString * status; // 订单状态

@property (nonatomic, copy)NSString * process; // 订单流程
@end
