//
//  ZRPaymentOrderCell.h
//  zhiruProduct
//
//  Created by nanding on 16/9/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRGroupBuyDetailModel;

typedef NS_ENUM(NSInteger, SelectedPayStyle) {
    PaypalSelected,
    WechatSelected,
    ZhifubaoSelected
};


@interface ZRPaymentOrderCell : UITableViewCell

+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath;

@property (nonatomic, strong) ZRGroupBuyDetailModel *groupBuyDetailModel;

@property (nonatomic, assign) SelectedPayStyle payStyle;
@property (nonatomic, strong) NSMutableArray *selectPayArray;
//0为团购，1为超市，2为午餐
@property (nonatomic, assign) NSInteger orderType;

//支付金额
@property (nonatomic, copy) NSString *payMoney;

@end
