//
//  ZRSupermarketHomeCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRSupermarketHomeModel.h"
@class ZRSupermarketHomeCell, ZRSupermarketGoodsListModel;
@protocol ZRSupermarketCellDelegate <NSObject>

- (void)addToShoppingCar:(ZRSupermarketHomeCell *)cell WithData:(ZRSupermarketGoodsListModel *)goodsListModel WithIndexPath:(NSIndexPath *)indexPath;


- (void)minusProduct:(ZRSupermarketHomeCell *)cell WithData:(ZRSupermarketGoodsListModel *)goodsListModel WithIndexPath:(NSIndexPath *)indexPath;

@end

@interface ZRSupermarketHomeCell : UITableViewCell

+(ZRSupermarketHomeCell *)cellWithTable:(UITableView *)table;

//@property (nonatomic, strong) NSArray *listArray;
@property (nonatomic, strong) ZRSupermarketGoodsListModel *goodsListModel;

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, weak) id<ZRSupermarketCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) NSString *countStr;


//超市ID
//@property (nonatomic, copy) NSString *supermarketId;
@property (nonatomic, strong) ZRSupermarketHomeModel *supermarketHomeModel;

- (void)deleteAnimation;

@end
