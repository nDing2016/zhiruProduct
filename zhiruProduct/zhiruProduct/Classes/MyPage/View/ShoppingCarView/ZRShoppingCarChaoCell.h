//
//  ZRShoppingCarChaoCell.h
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRMarketDetailModel.h"

@protocol ShoppingCarMarketCellDelegate <NSObject>

- (void)selectButtonClick:(UIButton *)sender andSection:(NSInteger)section andRow:(NSInteger)row;
- (void)deleteMarketNumSection:(NSInteger)section andRow:(NSInteger)row;
- (void)addMarketNumSection:(NSInteger)section andRow:(NSInteger)row;;


@end

@interface ZRShoppingCarChaoCell : UITableViewCell

@property (nonatomic, strong)UIButton * selectButton;// 选择按钮
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, strong)UIImageView * titleImage;// 商品图片

@property (nonatomic, strong)UIView * backView1; // // 展示内容背景View
@property (nonatomic, strong)UILabel * titleLabel; // 商品名称
@property (nonatomic, strong)UILabel * moneyLabel; // 价格
@property (nonatomic, strong)UILabel * weightLabel; // 重量
@property (nonatomic, strong)UILabel * partLabel;  // 数量

@property (nonatomic, strong)UIView * backView2;      // 展示
@property (nonatomic, strong)UIButton * subtractButton; // 减
@property (nonatomic, strong)UILabel * numberLabel;    // 数量
@property (nonatomic, strong)UIButton * addButton;    // 加

@property (nonatomic, strong)ZRMarketDetailModel * model;
@property (nonatomic, assign)id<ShoppingCarMarketCellDelegate>delegate;

@end
