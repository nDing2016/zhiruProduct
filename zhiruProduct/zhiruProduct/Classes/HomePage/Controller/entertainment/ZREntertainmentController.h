//
//  ZREntertainmentController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/7/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRHomeBaseViewController.h"
#import "ZRHomeNavModel.h"


@interface ZREntertainmentController : ZRHomeBaseViewController

@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *latitude;
@property (nonatomic , strong) ZRHomeNavModel * model;
@end
