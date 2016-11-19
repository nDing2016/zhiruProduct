//
//  ZRTest.m
//  zhiruProduct
//
//  Created by nanding on 16/10/15.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRTest.h"
#import "ZRGoodsModel.h"
#import "ZROtherGroupsModel.h"
#import "ZRGroupCommentListModel.h"


@implementation ZRTest

+(NSDictionary *)mj_objectClassInArray{
    return @{@"goods":[ZRGoodsModel class], @"otherGroup":[ZROtherGroupsModel class], @"commentList":[ZRGroupCommentListModel class]};
}



@end
