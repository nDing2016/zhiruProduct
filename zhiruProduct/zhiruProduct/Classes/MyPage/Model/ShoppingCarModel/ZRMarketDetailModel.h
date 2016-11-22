//
//  ZRMarketDetailModel.h
//  zhiruProduct
//
//  Created by pj on 16/9/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRMarketDetailModel : NSObject

// 商品Id
@property (nonatomic, copy)NSString * goodsId;
// 商品名称
@property (nonatomic, copy)NSString * goodsName;
// 图片地址
@property (nonatomic, copy)NSString * imgUrl;
// 价格
@property (nonatomic, copy)NSString * nowPrice;
// 超市Id
@property (nonatomic, copy)NSString * kaId;
// 重量: 单位KG
@property (nonatomic, copy)NSString * weight;
// 数量
@property (nonatomic, copy)NSString * num;
// 选择状态
@property (nonatomic, assign)BOOL selectState;
// 编辑数量状态
@property (nonatomic, assign)BOOL edtitngState;
@end
