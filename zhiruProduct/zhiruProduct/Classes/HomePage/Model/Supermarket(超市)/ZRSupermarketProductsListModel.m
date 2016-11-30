//
//  ZRSupermarketProductsListModel.m
//  zhiruProduct
//
//  Created by nanding on 16/8/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketProductsListModel.h"
#import "ZRSupermarketGoodsListModel.h"

@implementation ZRSupermarketProductsListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsList":[ZRSupermarketGoodsListModel class]};
}








@end
