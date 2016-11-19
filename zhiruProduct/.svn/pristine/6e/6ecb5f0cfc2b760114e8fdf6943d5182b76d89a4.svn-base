//
//  ZRShoppingHeaderView.h
//  zhiruProduct
//
//  Created by pj on 16/7/27.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRShoppingCarModel.h"
#import "ZRMarketModel.h"
@class ZRShoppingHeaderModel;


@protocol ZRShoppingHeaderViewDelegate <NSObject>

- (void)actionSectionHeaderView:(NSInteger)section;

@end

@interface ZRShoppingHeaderView : UIView

@property (nonatomic, strong)UIButton * selectButton;  // 选择
@property (nonatomic, strong)UILabel * titleLabel;     // 店铺名
@property (nonatomic, strong)UIImageView * rightImage; // 右箭头
@property (nonatomic, strong)UIButton * edtintButton;  // 编辑按钮
@property (nonatomic, strong)UIView * lineView;        // 1像素线

@property (nonatomic, strong)UIButton * clearButton; //透明button

@property (nonatomic, assign)NSInteger section;// 区

@property (nonatomic, assign)id<ZRShoppingHeaderViewDelegate>delegate;
@property (nonatomic, strong)ZRShoppingCarModel * model;
@property (nonatomic, strong)ZRMarketModel * marketModel;

@end
