//
//  ZRLookForTasteController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/5.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  寻味

#import "ZRBaseViewController.h"
#import "ZRHomeBaseViewController.h"
#import "ZRBusinessModel.h"

@interface ZRLookForTasteController : ZRHomeBaseViewController
@property (nonatomic , strong) ZRHomeNavModel * model;

@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *latitude;
@end