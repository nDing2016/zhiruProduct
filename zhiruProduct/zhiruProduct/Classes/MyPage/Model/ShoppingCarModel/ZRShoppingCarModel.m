//
//  ZRShoppingCarModel.m
//  zhiruProduct
//
//  Created by pj on 16/9/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRShoppingCarModel.h"
#import "ZRShoppingCarDetailModel.h"
@implementation ZRShoppingCarModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"groupList":[ZRShoppingCarDetailModel class]};
}

@end
