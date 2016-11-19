//
//  ZRSupermarketCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRSupermarketGoodsListModel,ZRSupermarketCell;
//@protocol ZRSupermarketCellDelegate <NSObject>
//
//- (void)addToShoppingCarWithCode:(NSString *)code WithCell:(ZRSupermarketCell *)cell;
//
//@end

@interface ZRSupermarketCell : UICollectionViewCell


//@property (nonatomic, strong) NSArray *listArr;

//索引
@property (nonatomic, assign) NSInteger cellIndex;


@property (nonatomic, strong) NSArray *travelArr;

@property (nonatomic, strong) NSArray *categoryTravelArr;


@property (nonatomic, strong) ZRSupermarketGoodsListModel *goodsList;

@property (nonatomic, strong) NSString *supermarketID;

//@property (nonatomic, strong) UIButton *shoppingCar;


//@property (nonatomic, weak) id<ZRSupermarketCellDelegate> delegate;

@property (nonatomic, strong) UIImage *img;

@end
