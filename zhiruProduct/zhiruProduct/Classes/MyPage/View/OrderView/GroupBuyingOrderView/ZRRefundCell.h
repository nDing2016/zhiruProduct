//
//  ZRRefundCell.h
//  zhiruProduct
//
//  Created by pj on 16/9/21.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRRefundCell : UITableViewCell

// 上短线
@property (nonatomic, strong)UIView * headerLine;
// 圆
@property (nonatomic, strong)UIView * roundView;
// 下长线
@property (nonatomic, strong)UIView * lineView;
// 标题
@property (nonatomic, strong)UILabel * titleLabel;
// 内容
@property (nonatomic, strong)UILabel * contentLabel;
// 时间
@property (nonatomic, strong)UILabel * timeLabel;

// state1: 用于判断显不显示上短线
@property (nonatomic, assign)BOOL state1;
// state2:
@property (nonatomic, assign)BOOL state2;
@end
