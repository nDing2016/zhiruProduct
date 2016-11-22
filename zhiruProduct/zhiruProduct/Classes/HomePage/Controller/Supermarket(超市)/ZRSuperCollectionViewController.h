//
//  ZRSuperCollectionViewController.h
//  zhiruProduct
//
//  Created by nanding on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRSupermarketHomeModel.h"
@class ZRSupermarketCell;
@interface ZRSuperCollectionViewController : ZRBaseViewController

@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  轮播图点击回调
 */
@property (nonatomic , copy) void (^clickImg)(NSInteger index,NSString * imageURL,UIImageView * imgView);

/**
 *  创建footer里的按钮
 *
 *  @param center
 *  @param view   
 */
- (UIView *)setUpBtnWithCheckAll:(CGPoint)center WithSupermarketModel:(ZRSupermarketHomeModel *)marketModel;


/**
 *  创建轮播图
 */
- (void)setUpAdView:(NSArray *)urlArr SuperView:(ZRSupermarketCell *)cell;


//@property (nonatomic, copy) NSString *supermarketId;
@property (nonatomic, strong) ZRSupermarketHomeModel *superHomeModel;

@property (nonatomic, strong) UIButton *shoppingCartBtn;

@end
