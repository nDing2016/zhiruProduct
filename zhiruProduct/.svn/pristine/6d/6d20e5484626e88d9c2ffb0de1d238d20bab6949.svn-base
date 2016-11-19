//
//  ZRDiscoveryCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRDiscoveryCell,ZRRecommendGroupListModel, ZRFindNewProduct, ZRCommodityListModel;
typedef NS_ENUM(NSInteger, UICollectionCellIndex) {
    index0,
    index1,
    index2
};


@protocol ZRDiscoveryCellDelegate <NSObject>

- (void)recommendSeeAll:(ZRDiscoveryCell *)cell WithTitle:(NSString *)titleStr;

- (void)integralMallClickToProductDetail:(ZRDiscoveryCell *)cell WithIndex:(NSInteger)index WithData:(ZRCommodityListModel *)commodityList;

/**
 *  跳转到团购详情页面
 */
- (void)pushToGroupBuyingDetailsControllerWithGroupList:(ZRRecommendGroupListModel *)groupListModel;
- (void)pushToGroupBuyingDetailsControllerWithList:(ZRFindNewProduct *)findNewProduct;


@end

@interface ZRDiscoveryCell : UICollectionViewCell

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, assign) UICollectionCellIndex cellIndex;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSArray *collectionArray;
@property (nonatomic, copy) NSString *collectionFirstImg;

@property (nonatomic, weak) id<ZRDiscoveryCellDelegate> delegate;

//悬浮向上的按钮
@property (nonatomic, strong) UIButton *upButton;


- (void)showUpButton:(BOOL)b;


@property (nonatomic, strong) NSMutableArray *navImgArr;
@property (nonatomic, strong) NSMutableArray *navTitleArr;
//判断引导的分类是否可点
@property (nonatomic, strong) NSArray *navClick;


@end
