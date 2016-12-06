//
//  ZRExchangeDetailModel.h
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRExchangeDetailModel : NSObject

// 兑换积分id
@property (nonatomic, copy)NSString * recordId;
// 创建日期
@property (nonatomic, copy)NSString * creatDate;
// 积分
@property (nonatomic, copy)NSString * points;
// 来源途径
@property (nonatomic ,copy)NSString * channel;
// 订单id
@property (nonatomic, copy)NSString * orderId;
@end
