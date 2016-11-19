//
//  ZROrderFormStatusController.h
//  zhiruProduct
//
//  Created by nanding on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"

@interface ZROrderFormStatusController : ZRBaseViewController
//订单号
@property (nonatomic, copy) NSString *orderIdStr;
//已支付价钱
@property (nonatomic, copy) NSString *orderPrice;
//骑士电话
@property (nonatomic, copy) NSString *riderPhoneStr;

@end
