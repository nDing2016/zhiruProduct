//
//  ZROrderingOrderCell.h
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZROrderContentView.h"

#import "ZRLunchModel.h"
#import "ZRLunchOrderModel.h"
@interface ZROrderingOrderCell : UITableViewCell

@property (nonatomic, strong)UILabel * orderState;
@property (nonatomic, strong)UILabel * timeLabel;
@property (nonatomic, strong)UIView * lineView1;
@property (nonatomic, strong)UIImageView * orderImage;
@property (nonatomic, strong)UILabel * orderingLabel;
@property (nonatomic, strong)UIImageView * rightImage;
@property (nonatomic, strong)UIView * lineView2;
@property (nonatomic, strong)ZROrderContentView * menuView1;
@property (nonatomic, strong)ZROrderContentView * menuView2;
@property (nonatomic, strong)UILabel * dianLabel;
@property (nonatomic, strong)UILabel * menuPartLabel;
@property (nonatomic, strong)UILabel * menuMoneyLabel;
@property (nonatomic, strong)UIView * lineView3;
@property (nonatomic, strong)UIButton * commentButton;
@property (nonatomic, strong)UIButton * againButton;

@property (nonatomic, strong)ZRLunchModel * lunchModel;

@end
