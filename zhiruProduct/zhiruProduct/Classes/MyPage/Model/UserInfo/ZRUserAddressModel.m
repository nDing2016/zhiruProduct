//
//  ZRUserAddressModel.m
//  zhiruProduct
//
//  Created by pj on 16/8/2.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRUserAddressModel.h"

@implementation ZRUserAddressModel

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    ZRUserAddressModel *user = [ZRUserAddressModel mj_objectWithKeyValues:dict];
    return user;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"addressId":@"id"};
}



@end
