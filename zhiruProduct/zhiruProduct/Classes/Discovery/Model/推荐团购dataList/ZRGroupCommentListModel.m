//
//  ZRGroupCommentListModel.m
//  zhiruProduct
//
//  Created by nanding on 16/8/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRGroupCommentListModel.h"
#import "ZRGroupCommentImgModel.h"

@implementation ZRGroupCommentListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"commentImg":[ZRGroupCommentImgModel class]};
}

@end
