//
//  ZRHomeDataModel.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeDataModel.h"

@implementation ZRHomeDataModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"mainNav":@"ZRNavModel" , @"boutiqueTourism" : @"ZRCircleImgModel" , @"extension" : @"ZRExtensionModel" , @"businessMsg" : @"ZRBusinessModel"};
}
@end
