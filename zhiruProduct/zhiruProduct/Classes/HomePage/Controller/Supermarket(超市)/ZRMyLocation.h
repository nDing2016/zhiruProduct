//
//  ZRMyLocation.h
//  zhiruProduct
//
//  Created by nanding on 16/9/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CallBack) (CLLocationCoordinate2D coodinate);

@interface ZRMyLocation : NSObject

+(instancetype)shareInstance;


@property (nonatomic, copy) NSString *myLocationStr;

-(void)getMylocation;

- (NSString *)reverseGeocodeWithLogitude:(NSString *)logitude WithLatitude:(NSString *)latitude;


//开放接口，获取经纬度
+ (void)geoSearchWithString:(NSString *)string Callback:(CallBack)callback;

@end
