//
//  ZRPointsModel.h
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRPointsModel : NSObject

// 用户积分
@property (nonatomic, copy)NSString * allPoints;
// 用户积分列表
@property (nonatomic, strong)NSArray * personalPoints;
@end
