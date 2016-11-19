//
//  ZRConfirmOrderController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  确认订单界面控制器
//***********超市调用 例子
//
//NSArray * arr =  [ZRSupermarketHomeObj shareInstance].selectedFoodsArray;
//ZRConfirmOrderController * confirmOrder = [[ZRConfirmOrderController alloc] init];
//confirmOrder.orderType = Supermarket;

//下面这部最后一步执行
//confirmOrder.productArr = arr;

typedef enum {
    
    Ordering = 0, //  订餐确认订单类型
    Supermarket ,     // 超市确认订单类型
    lunchOrdering
}confirmOrder;
#import "ZRUserInterfaceModel.h"
#import "ZRUserFindAddressModel.h"
#import "ZRBaseViewController.h"

#import "ZROrderingBusinessMsgModel.h"
@class ZRSupermarketHomeModel;
@interface ZRConfirmOrderController : ZRBaseViewController

//产品集合
@property (nonatomic , strong) NSArray * productArr;
@property (nonatomic , strong) ZROrderingBusinessMsgModel * businessMsg;
@property (nonatomic , strong) ZRUserFindAddressModel * addressModel;
//超市经纬度
@property (nonatomic, copy)NSString * longitude;
@property (nonatomic , copy) NSString * latitude;

@property (nonatomic, assign)CGFloat weather;
//是否是自己配送, 1是 默认不是.
@property (nonatomic , assign) BOOL  isDeliver;
//是否支持在线支付,0 不支持 1 支持
@property (nonatomic , assign) BOOL  isOnlinePay;

//确认订单类型
@property (nonatomic , assign) confirmOrder orderType;
//默认地址距离
@property (nonatomic , copy) NSString * distanceStr;
//超市信息模型
@property (nonatomic, strong) ZRSupermarketHomeModel *supermarketHomeModel;

// 判断超市商品结算渠道: 1是购物车
@property (nonatomic, copy)NSString * superOrderState;
@end
