//
//  ZRLunchModel.h
//  zhiruProduct
//
//  Created by pj on 16/10/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRLunchModel : NSObject

// 总价
@property (nonatomic, copy)NSString * canadianDollar;
// 订单Id
@property (nonatomic, copy)NSString * orderId;
// 店名
@property (nonatomic, copy)NSString * businessName;
// 下单时间
@property (nonatomic, copy)NSString * updateTime;
// 订单状态
@property (nonatomic, copy)NSString * status;
// list
@property (nonatomic, copy)NSArray * list;


@end
