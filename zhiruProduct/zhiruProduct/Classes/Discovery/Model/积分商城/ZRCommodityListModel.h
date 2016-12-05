//
//  ZRCommodityListModel.h
//  zhiruProduct
//
//  Created by nanding on 16/9/1.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRCommodityListModel : NSObject

//图片
@property (nonatomic, copy) NSString *img;

//会员所需积分
@property (nonatomic, copy) NSString *vipfraction;

//ID
@property (nonatomic, copy) NSString *commodityId;

//正常积分
@property (nonatomic, copy) NSString *fraction;

//商品名称
@property (nonatomic, copy) NSString *commodityName;

//剩余数量
@property (nonatomic, copy) NSString *num;

@end
