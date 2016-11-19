//
//  ZRAlterAddressViewController.h
//  zhiruProduct
//
//  Created by pj on 16/7/13.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRNewAddressViewController.h"
@class ZRUserAddressModel;

@protocol alterAddressDelegate <NSObject>

- (void)alterSuccess;

@end

@interface ZRAlterAddressViewController : ZRNewAddressViewController

@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * sex;
@property (nonatomic, copy)NSString * phoneNumber;

@property (nonatomic, strong)ZRUserAddressModel * model;

@property (nonatomic, assign)id<alterAddressDelegate>delegate;

// 经度
@property (nonatomic, copy)NSString * longitudeAlter;
// 维度
@property (nonatomic, copy)NSString * latitudeAlter;
// 街道
@property (nonatomic, copy)NSString * streetAlter;
// 城市
@property (nonatomic, copy)NSString * cityAlter;
//AB 艾伯塔省
@property (nonatomic, copy) NSString *administrativeAreaAlter;
//邮编
@property (nonatomic, copy) NSString *postalCodeStrAlter;

@end
