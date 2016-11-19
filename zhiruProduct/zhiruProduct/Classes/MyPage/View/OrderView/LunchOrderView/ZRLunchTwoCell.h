//
//  ZRLunchTwoCell.h
//  zhiruProduct
//
//  Created by pj on 16/10/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRLunchTwoCell : UITableViewCell

@property (nonatomic, strong)UIView * backView;
@property (nonatomic, strong)UILabel * shopName; // 店铺名
@property (nonatomic, strong)UIImageView * rightImg;// 右箭头
@property (nonatomic, strong)UIButton * clearBtn; // 透明按钮, 用于跳转到午餐店铺
@property (nonatomic, strong)UIView * lineView1; // 线1
@property (nonatomic, strong)UIView * menuBackView; // 菜单
@property (nonatomic, strong)UIView * lineView2; // 线2
@property (nonatomic, strong)UILabel * taxLabel; // 税费
@property (nonatomic, strong)UILabel * taxMoney; // 税费价格
@property (nonatomic, strong)UIView * lineView3; // 线3
@property (nonatomic, strong)UIButton * againButton; // 再来一单
@property (nonatomic, strong)UILabel * allLabel; // 合计
@property (nonatomic, strong)UILabel * allMoney; // 总价



@property (nonatomic, strong)NSArray * menuArray;
@end
