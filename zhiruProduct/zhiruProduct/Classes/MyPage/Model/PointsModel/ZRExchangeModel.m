//
//  ZRExchangeModel.m
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRExchangeModel.h"
#import "ZRExchangAllModel.h"
@implementation ZRExchangeModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"personalPoints":[ZRExchangAllModel class]};
}

@end
