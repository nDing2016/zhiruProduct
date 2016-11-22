//
//  ZRUserAddressModel.h
//  zhiruProduct
//
//  Created by pj on 16/8/2.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRUserAddressModel : NSObject


@property (nonatomic, copy)NSString * addressId;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * phone;
@property (nonatomic, assign)int gender;
@property (nonatomic, copy)NSString * longitude;
@property (nonatomic, copy)NSString * latitude;
@property (nonatomic, copy)NSString * address;
@property (nonatomic, assign)int isdefault;

@property (nonatomic, assign)BOOL state;

+ (instancetype)userWithDict:(NSDictionary *)dict;
@end
