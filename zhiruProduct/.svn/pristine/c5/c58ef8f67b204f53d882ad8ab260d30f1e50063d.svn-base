//
//  ZRShoppingCarTuanCell.h
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRShoppingCarDetailModel.h"
@protocol ShoppingCarGroupCellDelegate <NSObject>

- (void)selectButtonClick:(UIButton *)sender andSection:(NSInteger)section andRow:(NSInteger)row;
- (void)deleteGroupNumSection:(NSInteger)section andRow:(NSInteger)row;
- (void)addGroupNumSection:(NSInteger)section andRow:(NSInteger)row;;

@end



@interface ZRShoppingCarTuanCell : UITableViewCell


@property (nonatomic, strong)UIButton * selectButton; // 选择按钮
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, assign)NSInteger row;
@property (nonatomic, strong)UIImageView * titleImage; // 团购产品图片

@property (nonatomic, strong)UIView * backView1;      // 展示内容背景View
@property (nonatomic, strong)UILabel * titleLabel;    // 团购产品名称
@property (nonatomic, strong)UILabel * moneyLabel;    // 团购产品价格
@property (nonatomic, strong)UILabel * partLabel;     // 份数

@property (nonatomic, strong)UIView * backView2;      // 展示
@property (nonatomic, strong)UIButton * subtractButton; // 减
@property (nonatomic, strong)UILabel * numberLabel;    // 数量
@property (nonatomic, strong)UIButton * addButton;    // 加



@property (nonatomic, strong)ZRShoppingCarDetailModel * model;

@property (nonatomic, assign)id<ShoppingCarGroupCellDelegate>delegate;
@end
