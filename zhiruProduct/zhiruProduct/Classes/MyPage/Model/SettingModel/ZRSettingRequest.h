//
//  ZRSettingRequest.h
//  zhiruProduct
//
//  Created by pj on 16/11/1.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRSettingRequest : NSObject
/*
 * 获取版本号
 * callBack 成功
 * failure  失败
 */
+ (void)getVersionNumberCallBack:(void(^)(id success))callBack
                         Failure:(void(^)(id error))failure;
@end
