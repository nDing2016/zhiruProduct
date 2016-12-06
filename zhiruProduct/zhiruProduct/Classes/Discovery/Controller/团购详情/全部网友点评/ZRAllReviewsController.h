//
//  ZRAllReviewsController.h
//  zhiruProduct
//
//  Created by nanding on 16/7/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRGoupBuyingReviewFrame.h"

typedef NS_ENUM(NSInteger, AllReviewsType) {
    ZROrderingReviews,               //订餐评论
    ZRShopReviews,                  //店铺评论
    ZRGroupBuyingReviews           //团购评论
    
};


typedef NS_ENUM(NSInteger, ShopType) {
    ZRXunWei =100,               //寻味评论
    ZRYuLe,                  //娱乐评论
    ZRLiRen                  //丽人评论
    
};




@interface ZRAllReviewsController : ZRBaseViewController

@property (nonatomic, strong) UITableView *tableView;

//评论类型
@property (nonatomic, assign) AllReviewsType reviewsType;

//店铺类型
@property (nonatomic, assign) ShopType shopType;

@property (nonatomic, strong) NSMutableArray *commentListArray;

//全部评论
@property (nonatomic, copy) NSString *allReviewsCount;

//好评数
@property (nonatomic, copy) NSString *goodReviewsCount;

//差评数
@property (nonatomic, copy) NSString *badReviewsCount;

//带图评论数
@property (nonatomic, copy) NSString *imgReviewsCount;

//店铺评论
@property (nonatomic, copy) NSString *businessId;


@property (nonatomic, assign) NSInteger btnTag;

@property (nonatomic, assign) NSInteger allPage;
@property (nonatomic, assign) NSInteger goodPage;
@property (nonatomic, assign) NSInteger badPage;
@property (nonatomic, assign) NSInteger picPage;


@property (nonatomic, strong) ZRGoupBuyingReviewFrame *reviewFrame;


//从该页面到点评详情，纪录行号，再返回的时候直接滚到该行
@property (nonatomic, assign) NSInteger indexPathRow;


@end
