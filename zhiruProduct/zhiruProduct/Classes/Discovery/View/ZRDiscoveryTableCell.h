//
//  ZRDiscoveryTableCell.h
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, DiscoveryKinds) {
//    RecommendType,         // 推荐
//    LatestProductType      //新品
//};


@class ZRDiscoveryTableCell, ZRRecommendGroupListModel, ZRFindNewProduct;
@protocol ZRDiscoveryTableCellDelegate <NSObject>

- (void)categoriesClick:(NSInteger)btnTag withCell:(ZRDiscoveryTableCell *)tableCell;

@end

@interface ZRDiscoveryTableCell : UITableViewCell

@property (nonatomic, strong) ZRRecommendGroupListModel *groupListModel;
@property (nonatomic, strong) NSArray *navImageArray;
@property (nonatomic, strong) NSArray *navTitleArray;



//@property (nonatomic, strong) NSArray *latestProductArr;
@property (nonatomic, strong) ZRFindNewProduct *findNewProduct;

@property (nonatomic, strong) UIImageView *imgView;

//@property (nonatomic, assign) DiscoveryKinds kinds;

@property (nonatomic, weak) id<ZRDiscoveryTableCellDelegate> delegate;

+(ZRDiscoveryTableCell *)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withKinds:(NSInteger)kinds;


@end
