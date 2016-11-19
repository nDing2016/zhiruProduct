//
//  ZRSupermarketHomeModel.m
//  zhiruProduct
//
//  Created by nanding on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketHomeModel.h"
#import "ZRSupermarketNavListModel.h"
#import "ZRSupermarketGoodsListModel.h"

@implementation ZRSupermarketHomeModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"navList":[ZRSupermarketNavListModel class], @"goodsList":[ZRSupermarketGoodsListModel class]};
}


@end
