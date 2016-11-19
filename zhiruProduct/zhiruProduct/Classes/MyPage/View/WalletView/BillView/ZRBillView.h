//
//  ZRBillView.h
//  zhiruProduct
//
//  Created by pj on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class ZRBillContentView;
#import "ZRBillContentView.h"
@interface ZRBillView : UIView

@property (nonatomic, strong)UIImageView * Image;
@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)UILabel * moneyLabel;
@property (nonatomic, strong)UILabel * billState;

@property (nonatomic, strong)ZRBillContentView * manner;// 付款方式
@property (nonatomic, strong)ZRBillContentView * explain;// 商品说明
@property (nonatomic, strong)ZRBillContentView * date;// 创建说明
@end
