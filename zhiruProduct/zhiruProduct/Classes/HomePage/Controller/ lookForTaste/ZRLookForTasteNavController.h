//
//  ZRLookForTasteNavController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/9/1.
//  Copyright © 2016年 Zhiru. All rights reserved.
//
typedef enum : NSUInteger {
    xunwen,
    liren ,
    yule ,
    
} VCType;
#import "ZRHomeBaseViewController.h"

@interface ZRLookForTasteNavController : ZRHomeBaseViewController

//判断是否是 丽人娱乐
@property (nonatomic , assign) VCType type;

@property (nonatomic , strong) ZRHomeNavModel * model ;
@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *latitude;
@end
