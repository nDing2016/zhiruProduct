//
//  ZRSupermarketHomeModel.h
//  zhiruProduct
//
//  Created by nanding on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRSupermarketHomeModel : NSObject
//超市名称
@property (nonatomic, copy) NSString *kaName;

//超市id
@property (nonatomic, copy) NSString *kaId;

//首页四个导航
@property (nonatomic, strong) NSArray *navList;

//打折商品列表
@property (nonatomic, strong) NSArray *goodsList;





@end
