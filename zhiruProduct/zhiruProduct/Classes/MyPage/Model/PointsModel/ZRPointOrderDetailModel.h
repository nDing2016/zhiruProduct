//
//  ZRPointOrderDetailModel.h
//  zhiruProduct
//
//  Created by pj on 16/12/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRPointOrderDetailModel : NSObject
// 收货人名称
@property (nonatomic, copy)NSString * receipt_name;
// 收获地址
@property (nonatomic, copy)NSString * receipt_address;
// 性别  0男1女
@property (nonatomic, copy)NSString * gender;
// 数量
@property (nonatomic, copy)NSString * num;
// 消耗积分
@property (nonatomic, copy)NSString * points;
// 物品id
@property (nonatomic, copy)NSString * commodity_id;
// 用户id
@property (nonatomic, copy)NSString * user_id;
// 状态    1是被删除
@property (nonatomic, copy)NSString * state;
// 创建时间
@property (nonatomic ,copy)NSString * create_date;
// 订单号
@property (nonatomic, copy)NSString * order_id;
// 收货人电话
@property (nonatomic, copy)NSString * receipt_phone;
// 备注
@property (nonatomic, copy)NSString * remarks;
// 物品名称
@property (nonatomic, copy)NSString * commodity_name;
// 订单状态 0进行中1已完成
@property (nonatomic, copy)NSString * status;

@end
