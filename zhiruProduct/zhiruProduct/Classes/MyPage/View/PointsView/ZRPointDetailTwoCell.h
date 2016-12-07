//
//  ZRPointDetailTwoCell.h
//  zhiruProduct
//
//  Created by pj on 16/12/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRLunchView.h"
#import "ZRPointOrderDetailModel.h"
#import "ZRPointView.h"
@interface ZRPointDetailTwoCell : UITableViewCell

@property (nonatomic, strong)UILabel * titlaLabel;
@property (nonatomic, strong)ZRPointView * orderName;
@property (nonatomic, strong)ZRPointView * orderPhone;
@property (nonatomic, strong)ZRLunchView * orderAddress;
@property (nonatomic, strong)ZRPointOrderDetailModel * model;
@end
