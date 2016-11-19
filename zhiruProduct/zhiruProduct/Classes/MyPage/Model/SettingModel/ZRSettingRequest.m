//
//  ZRSettingRequest.m
//  zhiruProduct
//
//  Created by pj on 16/11/1.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSettingRequest.h"
#import "ZRVersionNumberModel.h"
@implementation ZRSettingRequest

static NSString * const getNumber = @"version/getNumber";

/*
 * 获取版本号
 * callBack 成功
 * failure  失败
 */
+ (void)getVersionNumberCallBack:(void(^)(id success))callBack
                         Failure:(void(^)(id error))failure
{
    NSString * url = [HOST stringByAppendingString:getNumber];
    [ZRAFNRequests post:url parameters:nil success:^(id result) {
        ZRVersionNumberModel * model = [ZRVersionNumberModel mj_objectWithKeyValues:result];
        callBack(model);
    } failure:^(id error) {
        failure(error);
    }];
}
@end
