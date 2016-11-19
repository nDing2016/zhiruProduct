//
//  ZRLunchOrderDetailModel.h
//  zhiruProduct
//
//  Created by pj on 16/10/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRLunchOrderDetailModel : NSObject

// 取餐地址
@property (nonatomic, copy)NSString * receipt_address;
// 负责人电话
@property (nonatomic, copy)NSString * person_phone;
// 菜单列表
@property (nonatomic, copy)NSArray * goodsList;
// 负责人姓名
@property (nonatomic, copy)NSString * person_name;
// 在线支付
@property (nonatomic, copy)NSString * pay_method;
// 订单状态更新时间
@property (nonatomic, copy)NSString * update_time;
// 总价
@property (nonatomic, copy)NSString * canadian_dollar;
// 配送时间
@property (nonatomic, copy)NSString * send_time;
// 取餐人电话
@property (nonatomic, copy)NSString * take_meal_phone;
// 订单创建时间
@property (nonatomic, copy)NSString * create_date;
// 订单号
@property (nonatomic, copy)NSString * order_id;
// 税
@property (nonatomic, copy)NSString * taxation;
// 备注
@property (nonatomic, copy)NSString * remarks;
// 订单状态0未付款1等待接单2已接单进行中3.已取消4.已完成,
@property (nonatomic, copy)NSString * status;
// 取餐人姓名
@property (nonatomic, copy)NSString * take_meal_name;
@end
