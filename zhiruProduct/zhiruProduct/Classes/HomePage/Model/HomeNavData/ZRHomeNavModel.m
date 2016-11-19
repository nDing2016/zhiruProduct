//
//  ZRHomeNavModel.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/10.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeNavModel.h"

@implementation ZRHomeNavModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"region":@"ZRRegionModel" , @"label" : @"ZRLabelModel" , @"businessMsg" : @"ZRBusinessModel" , @"nav" : @"ZRNavModel",@"groupList" : @"ZRGroupModel" };
}
@end
