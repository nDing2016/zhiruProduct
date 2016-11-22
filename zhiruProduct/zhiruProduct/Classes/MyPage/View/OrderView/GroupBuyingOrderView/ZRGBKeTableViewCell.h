//
//  ZRGBKeTableViewCell.h
//  zhiruProduct
//
//  Created by pj on 16/7/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRGBKeTableViewCell : UITableViewCell

@property (nonatomic, strong)UIView * headerBackView;
@property (nonatomic, strong)UILabel * businessLabel;    // 店铺名称
@property (nonatomic, strong)UILabel * moneyTitleLabel;  // 实付:
@property (nonatomic, strong)UILabel * moneyLabel;       // 实付金额
@property (nonatomic, strong)UIImageView * rightImage;   // 右图标

@property (nonatomic, strong)UIView * lineView; // 分割线

@property (nonatomic, strong)UIView * footerBackView;
@property (nonatomic, strong)UIImageView * businessImage;// 店铺图片
@property (nonatomic, strong)UILabel * groupLabel;       // 套餐名称
@property (nonatomic, strong)UILabel * groupTitleLabel;  // 价格:
@property (nonatomic, strong)UILabel * groupMoneyLabel;  // 套餐价格
@property (nonatomic, strong)UILabel * timeLabel;        // 有效期
@property (nonatomic, strong)UILabel * stateLabel;       // 订单状态
@property (nonatomic, strong)UIButton * button;

@end
