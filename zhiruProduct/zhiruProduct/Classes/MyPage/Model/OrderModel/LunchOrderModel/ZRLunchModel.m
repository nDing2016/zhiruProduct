//
//  ZRLunchModel.m
//  zhiruProduct
//
//  Created by pj on 16/10/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRLunchModel.h"
#import "ZRLunchOrderModel.h"
@implementation ZRLunchModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list":[ZRLunchOrderModel class]};
}

@end
