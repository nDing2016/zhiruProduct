//
//  ZRAddShoppingCarView.h
//  zhiruProduct
//
//  Created by nanding on 16/7/11.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRSupermarketGoodsListModel, ZROrderingMenuModel;




@interface ZRAddShoppingCarView : UIView

@property (nonatomic, strong) UIButton *shoppingCatBtn;

//接收加入购物车传过来的数据
//@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) ZRSupermarketGoodsListModel *goodsListModel;

@property (nonatomic, strong) ZROrderingMenuModel *orderingMenuModel;


@property (nonatomic, assign) CGFloat price;

@property (nonatomic, assign) NSInteger viewTag;

@property (nonatomic, strong) UILabel *redLabel;
//还差多少钱起送
@property (nonatomic, copy) NSString *leftStr;

@property (nonatomic , assign) BOOL isLunch;

- (void)minusWithGoods:(NSObject *)goods;




@end
