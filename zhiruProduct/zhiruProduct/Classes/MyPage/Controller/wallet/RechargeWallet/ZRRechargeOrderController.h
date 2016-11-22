//
//  ZRRechargeOrderController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"

@interface ZRRechargeOrderController : ZRBaseViewController

@property (nonatomic, copy)NSString * orderName; // 商品名称

@property (nonatomic , copy) NSString * moneyCount; // 单价

@property (nonatomic, copy)NSString * count; // 数量

/**
 * 订单类型
 * 1是团购
 * 2是会员卡
 */
@property (nonatomic, assign)NSInteger type;

@end
