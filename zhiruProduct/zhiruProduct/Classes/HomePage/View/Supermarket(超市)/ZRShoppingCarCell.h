//
//  ZRShoppingCarCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/14.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRSupermarketGoodsListModel, ZROrderingMenuModel;
@interface ZRShoppingCarCell : UITableViewCell


//@property (nonatomic, strong)NSArray *dataArr;
//@property (nonatomic, strong) ZRSupermarketGoodsListModel *goodsListModel;
//
//@property (nonatomic, strong) ZROrderingMenuModel *menuModel;


@property (nonatomic, strong) NSObject *model;

//商品数量
@property (nonatomic, assign) NSInteger num;


@property (nonatomic, strong) NSIndexPath *idxPath;

//区分超市购物车和外卖购物车
@property (nonatomic, assign) NSInteger viewTag;


+(instancetype)cellWithTable:(UITableView *)table IndexPath:(NSIndexPath *)idxPath;

@end
