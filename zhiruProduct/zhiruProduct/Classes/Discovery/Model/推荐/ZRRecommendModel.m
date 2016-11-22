//
//  ZRRecommendModel.m
//  zhiruProduct
//
//  Created by nanding on 16/8/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRRecommendModel.h"
#import "ZRRecommendGroupListModel.h"

@implementation ZRRecommendModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"groupList":[ZRRecommendGroupListModel class]};
}

@end
