//
//  ZROrderingDetailsController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  订餐详情

#import "ZRBaseViewController.h"

@interface ZROrderingDetailsController : ZRBaseViewController
@property (nonatomic , copy) NSString * businessId;

//如果是 午餐界面 传isLunch = yes;
@property (nonatomic , assign) BOOL isLunch;

@property (nonatomic  , strong) UITableView * myTableView;

@end
