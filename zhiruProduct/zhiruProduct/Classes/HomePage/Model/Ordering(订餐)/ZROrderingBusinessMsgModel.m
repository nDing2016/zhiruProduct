//
//  ZROrderingBusinessMsgModel.m
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderingBusinessMsgModel.h"

@implementation ZROrderingBusinessMsgModel
+(NSDictionary *)mj_objectClassInArray{
    return @{@"nav":@"ZROrderingNavModel" , @"readdress" : @"ZROrderingAddress" };
}
@end
