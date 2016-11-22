//
//  ZROrderFormStatusCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/26.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRSuperOrderProcessModel;
@interface ZROrderFormStatusCell : UITableViewCell

@property (nonatomic, assign)NSInteger status;

@property (nonatomic, strong) NSIndexPath *idxPath;
//订单号
@property (nonatomic, copy) NSString *orderId;
//总价
@property (nonatomic, copy) NSString *totalPrice;
//骑士电话
@property (nonatomic, copy) NSString *riderTele;

@property (nonatomic, strong) ZRSuperOrderProcessModel *processModel;


+(instancetype)cellWithTable:(UITableView *)table ForIndexPath:(NSIndexPath *)idxPath;

@end
