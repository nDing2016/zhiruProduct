//
//  ZROrderingModel.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingModel.h"

@implementation ZROrderingModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"businessMsg":@"ZROrderingBusinessMsg" , @"region" : @"ZRRegionModel" , @"label" : @"ZRLabelModel"};
    
}
@end
