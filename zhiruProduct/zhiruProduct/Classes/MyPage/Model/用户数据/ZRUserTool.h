//
//  ZRUserTool.h
//  zhiruProduct
//
//  Created by nanding on 16/7/28.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZRUser;
@interface ZRUserTool : NSObject

+ (BOOL)saveAccount:(ZRUser *)user;

+ (ZRUser *)user;


@end
