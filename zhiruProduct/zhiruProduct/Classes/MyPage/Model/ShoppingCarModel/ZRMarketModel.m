//
//  ZRMarketModel.m
//  zhiruProduct
//
//  Created by pj on 16/9/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRMarketModel.h"
#import "ZRMarketDetailModel.h"

@implementation ZRMarketModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsList":[ZRMarketDetailModel class]};
}

@end
