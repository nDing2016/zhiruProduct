//
//  ZRExchangAllModel.h
//  zhiruProduct
//
//  Created by pj on 16/9/7.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRExchangAllModel : NSObject

// 年月
@property (nonatomic, copy)NSString * date;
// 积分明细详情
@property (nonatomic, strong)NSArray * list;
@end
