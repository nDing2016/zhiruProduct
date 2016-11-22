//
//  ZRPaymentOrderController.h
//  zhiruProduct
//
//  Created by nanding on 16/9/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"

@class ZRGroupBuyDetailModel, ZRSupermarketHomeModel, ZRAddKaOrderModel;
typedef NS_ENUM(NSInteger, ZRPayOrderType) {
    ZRPayOrderSupermarket,          // 超市
    ZRPayorderGroupBuy,             // 团购
    ZRPayOrderLunch                 // 特惠午餐
};


@interface ZRPaymentOrderController : ZRBaseViewController

@property (nonatomic, assign) ZRPayOrderType payOrderType;

@property (nonatomic, strong) ZRGroupBuyDetailModel *groupBuyDetailModel;

@property (nonatomic, copy) NSString *payPrice;

//提交订单返回信息模型
@property (nonatomic, strong) ZRAddKaOrderModel *addKaOrderModel;



@end
