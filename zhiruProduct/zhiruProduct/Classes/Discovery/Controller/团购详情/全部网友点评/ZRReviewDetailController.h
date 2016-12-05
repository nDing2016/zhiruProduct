//
//  ZRReviewDetailController.h
//  zhiruProduct
//
//  Created by nanding on 16/11/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  点评详情

#import "ZRAllReviewsController.h"

@interface ZRReviewDetailController : ZRAllReviewsController

@property (nonatomic, copy) NSString *commentIdStr;

@property (nonatomic, copy) NSString *businessId;

//100寻味，101娱乐，102丽人
@property (nonatomic, assign) NSInteger shoptype;

@end
