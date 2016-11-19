//
//  ZRHomeInterfaceModel.m
//  zhiruProduct
//
//  Created by nanding on 16/7/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeInterfaceModel.h"

@implementation ZRHomeInterfaceModel

/**
 *  APP首页接口
 *
 *  @param longitude 经度
 *  @param latitude  纬度
 *  @param callback  成功回调
 */
+(void)homeWithLongitude:(NSString *)longitude
                Latitude:(NSString *)latitude
                Callback:(HomeCallBack)callback
{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:longitude forKey:@"longitude"];
    [paramDic setObject:latitude forKey:@"latitude"];
    __block NSString *str;
    [ZRAFNRequests post:@"index" parameters:paramDic success:^(id result) {
        
        NSDictionary *dic = result;
        str = [dic objectForKey:@"message"];
        id data = [dic objectForKey:@"data"];
        if (callback) {
            callback(str,data);
        }
        
        
    } failure:^(id error) {
        
    }];

}

@end
