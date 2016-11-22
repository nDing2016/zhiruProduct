//
//  ZRPointsModel.m
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRPointsModel.h"
#import "ZRPointsAllModel.h"
@implementation ZRPointsModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"personalPoints":[ZRPointsAllModel class]};
}
@end
