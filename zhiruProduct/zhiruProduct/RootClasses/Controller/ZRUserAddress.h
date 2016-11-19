//
//  ZRUserAddress.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/11/18.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRUserAddress : NSObject

@property (nonatomic , copy) NSString * Longitude;
@property (nonatomic , copy) NSString * Latitude;

//单例
+(id)sharedInstance;
//开始定位
- (void)startLocation;

@end
