//
//  ZRLunchFourCell.h
//  zhiruProduct
//
//  Created by pj on 16/10/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRLunchView.h"
@interface ZRLunchFourCell : UITableViewCell

@property (nonatomic, strong)UIView * backView;

@property (nonatomic, strong)UILabel * titleLabel; // 订单详情

@property (nonatomic, strong)ZRLunchView * orderNumber; // 订单号

@property (nonatomic, strong)ZRLunchView * name; // 联系人

@property (nonatomic, strong)ZRLunchView * phone; // 联系电话

@property (nonatomic, strong)ZRLunchView * address; // 取餐地址

@property (nonatomic, strong)ZRLunchView * pay; // 支付方式

@property (nonatomic, strong)ZRLunchView * timer1; // 下单时间

@property (nonatomic, strong)ZRLunchView * timer2; // 取餐时间
@end
