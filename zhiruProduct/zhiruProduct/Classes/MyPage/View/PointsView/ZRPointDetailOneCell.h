//
//  ZRPointDetailOneCell.h
//  zhiruProduct
//
//  Created by pj on 16/12/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRLunchView.h"
#import "ZRPointOrderDetailModel.h"
@interface ZRPointDetailOneCell : UITableViewCell

@property (nonatomic, strong)UILabel * titlaLabel;
@property (nonatomic, strong)ZRLunchView * orderId;
@property (nonatomic, strong)ZRLunchView * orderName;
@property (nonatomic, strong)ZRLunchView * orderState;
@property (nonatomic, strong)ZRLunchView * orderTime;
@property (nonatomic, strong)ZRLunchView * orderPoint;
@property (nonatomic, strong)ZRLunchView * orderNum;

@property (nonatomic, strong)ZRPointOrderDetailModel * model;
@end
