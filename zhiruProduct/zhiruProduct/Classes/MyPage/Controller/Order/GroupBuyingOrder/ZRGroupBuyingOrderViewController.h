//
//  ZRGroupBuyingOrderViewController.h
//  zhiruProduct
//
//  Created by pj on 16/7/16.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRHeaderView.h"



@interface ZRGroupBuyingOrderViewController : ZRBaseViewController

@property (nonatomic, strong)NSArray * array;
@property (nonatomic, strong)ZRHeaderView * headerView;
@property (nonatomic, strong)UICollectionView * collectionView;
@end
