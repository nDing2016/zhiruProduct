//
//  ZRNewAddressViewController.h
//  zhiruProduct
//
//  Created by pj on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRNewAddressView.h"

@protocol newAddressDelegate <NSObject>

- (void)newAddress;

@end

@interface ZRNewAddressViewController : ZRBaseViewController

@property (nonatomic, strong)ZRNewAddressView * addView;
@property (nonatomic, strong)UIButton * okButton;

@property (nonatomic, assign)id<newAddressDelegate>delegates;

// 经度
@property (nonatomic, copy)NSString * longitude;
// 维度
@property (nonatomic, copy)NSString * latitude;
// 街道
@property (nonatomic, copy)NSString * street;
// 城市
@property (nonatomic, copy)NSString * city;
//AB 艾伯塔省
@property (nonatomic, copy) NSString *administrativeArea;
//邮编
@property (nonatomic, copy) NSString *postalCodeStr;


@end
