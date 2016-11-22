//
//  ZRSuperOrderDetailsController.h
//  zhiruProduct
//
//  Created by nanding on 16/7/25.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZROrderDetailsController.h"

@interface ZRSuperOrderDetailsController : ZROrderDetailsController

//订单号
@property (nonatomic, copy) NSString *orderIdStr;


//是否可以删除, yes为可以删除， no为不可删除
@property (nonatomic, assign) BOOL canDelete;

@end
