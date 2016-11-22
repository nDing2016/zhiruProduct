//
//  ZRTuanOneCell.h
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRTuanOneCell : UITableViewCell

// 线1
@property (nonatomic, strong)UIView * lineView1;
// 团购名称
@property (nonatomic, strong)UILabel * groupNameLabel;
// 团购价格
@property (nonatomic, strong)UILabel * groupMoneyLabel;
// 线2
@property (nonatomic, strong)UIView * lineView2;
// 数量标题
@property (nonatomic, strong)UILabel * groupNumLabel;
// 数量
@property (nonatomic, strong)UILabel * groupCountLabel;
// 线3
@property (nonatomic, strong)UIView * lineView3;
// 小计标题
@property (nonatomic, strong)UILabel * totalLabel;
// 小计价格
@property (nonatomic, strong)UILabel * totalMoneyLabel;
// 线4
@property (nonatomic, strong)UIView * lineView4;

@end
