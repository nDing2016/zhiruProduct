//
//  ZROrderingDetailModel.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingDetailModel.h"

@implementation ZROrderingDetailModel


+(NSDictionary *)mj_objectClassInArray{
    return @{@"footList":@"ZROrderingFootListModel",@"commentList" : @"ZRCommentListModel" };
}
@end
