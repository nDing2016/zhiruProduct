//
//  ZRTuanTotalCell.h
//  zhiruProduct
//
//  Created by pj on 16/9/19.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRTuanTotalCell : UITableViewCell

// 线1
@property (nonatomic, strong)UIView * lineView1;
// 合计
@property (nonatomic, strong)UILabel * totalLabel;
// 价钱
@property (nonatomic, strong)UILabel * totalMoneyLabel;
// 线2
@property (nonatomic, strong)UIView * lineView2;
@end
