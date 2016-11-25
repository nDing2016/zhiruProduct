//
//  ZRSupermarketProductsListModel.h
//  zhiruProduct
//
//  Created by nanding on 16/8/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRSupermarketProductsListModel : NSObject<NSCoding>

//首页导航ID
@property (nonatomic, copy) NSString *navId;

//商品列表
@property (nonatomic, strong) NSArray *goodsList;

@property (nonatomic, copy) NSString *navName;

//@property (nonatomic, strong) NSArray *dataArray;

@end
