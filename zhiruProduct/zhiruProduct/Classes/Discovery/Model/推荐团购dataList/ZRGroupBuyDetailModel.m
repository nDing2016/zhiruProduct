//
//  ZRGroupBuyDetailModel.m
//  zhiruProduct
//
//  Created by nanding on 16/8/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupBuyDetailModel.h"
#import "ZRGoodsModel.h"
#import "ZROtherGroupsModel.h"
#import "ZRGroupCommentListModel.h"

@implementation ZRGroupBuyDetailModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"goods":[ZRGoodsModel class], @"otherGroup":[ZROtherGroupsModel class], @"commentList":[ZRGroupCommentListModel class]};
}


@end
