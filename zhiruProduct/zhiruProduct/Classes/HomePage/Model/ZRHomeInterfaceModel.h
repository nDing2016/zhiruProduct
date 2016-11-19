//
//  ZRHomeInterfaceModel.h
//  zhiruProduct
//
//  Created by nanding on 16/7/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HomeCallBack) (NSString *message, id data);

@interface ZRHomeInterfaceModel : NSObject

/**
 *  APP首页接口
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param callback  成功回调
 */
+(void)homeWithLongitude:(NSString *)longitude
                Latitude:(NSString *)latitude
                Callback:(HomeCallBack)callback;

@end
