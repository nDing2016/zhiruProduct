//
//  ZROrderingModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZROrderingModel : NSObject

@property (nonatomic , strong) NSArray * region;

@property (nonatomic , strong) NSArray * label;

/**
 *  订餐 店铺详情
 */
@property (nonatomic , strong) NSArray * businessMsg;

@end
