//
//  ZRShoppingCarDetailModel.h
//  zhiruProduct
//
//  Created by pj on 16/9/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRShoppingCarDetailModel : NSObject

// 团购ID
@property (nonatomic, copy)NSString * groupId;
// 团购名称
@property (nonatomic, copy)NSString * groupName;
// 图片地址
@property (nonatomic, copy)NSString * groupImg;
// 店铺ID
@property (nonatomic ,copy)NSString * businessId;
// 价格
@property (nonatomic, copy)NSString * nowPrice;
// 数量
@property (nonatomic, copy)NSString * num;
// 状态
@property (nonatomic, assign)BOOL state;
// 编辑数量状态
@property (nonatomic, assign)BOOL edtitngState;
@end
