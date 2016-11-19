//
//  orderingDetailsHeadView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  订餐界面 头视图

#import <UIKit/UIKit.h>
#import "ZROrderingBusinessMsgModel.h"


@interface orderingDetailsHeadView : UIView

@property (nonatomic , strong) ZROrderingBusinessMsgModel * model;

@property (nonatomic , assign) BOOL isLunch;

@end
