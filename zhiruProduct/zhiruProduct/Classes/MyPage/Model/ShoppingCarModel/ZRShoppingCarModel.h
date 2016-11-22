//
//  ZRShoppingCarModel.h
//  zhiruProduct
//
//  Created by pj on 16/9/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRShoppingCarModel : NSObject

// 店铺名称
@property (nonatomic, copy)NSString * businessName;
// 团购列表
@property (nonatomic, strong)NSArray * groupList;
// 选择状态
@property (nonatomic, assign)BOOL headerSelectState;
// 编辑状态
@property (nonatomic, assign)BOOL editingState;
@end
