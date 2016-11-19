//
//  ZRSettingPasswordViewController.h
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRBaseViewController.h"
#import "ZRRegisterView.h"

@interface ZRSettingPasswordViewController : ZRBaseViewController


@property (nonatomic, strong)ZRRegisterView * passWord;
@property (nonatomic, strong)ZRRegisterView * againPassWord;
@property (nonatomic, strong)UIButton * button;

@property (nonatomic, copy)NSString * phone;
@property (nonatomic, copy)NSString * vCode;
@end
