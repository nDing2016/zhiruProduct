//
//  ZROrderDetailsController.h
//  zhiruProduct
//
//  Created by nanding on 16/7/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRSuperDetailsModel.h"
#import "ZRSuperOrderFrame.h"

typedef NS_ENUM(NSInteger, OrderFormStatus) {
    OrderFormSubmitSucceed,          // 订单提交成功
    OrderFormPayoff,                 // 订单已支付
    WaitingMerchantOrders,           // 等待商户接单
    MerchantHaveConfirmedOrders,     // 商家已经确认订单
    DeliverymanHasPickup,            // 骑士已取货
    OrderHasFinished                 // 订单已完成
};

typedef NS_ENUM(NSInteger, OrderDetailsType) {
    OrderDetailsGroupBuying,         //团购订单详情
    OrderDetailsOrdering,            //订餐/外卖订单详情
    OrderDetailsTravel,              //旅游订单详情
    OrderDetailsSupermarket          //超市订单详情
};


@interface ZROrderDetailsController : ZRBaseViewController

@property (nonatomic, assign) NSInteger sectionNum;

//@property (nonatomic, assign) OrderFormStatus orderStatus;

@property (nonatomic, copy) NSString *orderTime;

@property (nonatomic, copy) NSString *nameStr;

@property (nonatomic, strong) NSArray *productsArr;


//所有数据
@property (nonatomic, strong) NSArray *orderFormArr;

//订单详情枚举
@property (nonatomic, assign) OrderDetailsType orderDetailsType;
//当前订单状态
@property (nonatomic, copy) NSString *orderDetailsStr;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *orderImageUrl;

@property (nonatomic, strong) ZRSuperDetailsModel *kaDetailModel;


@property (nonatomic, strong) ZRSuperOrderFrame *orderFrame;

@end
