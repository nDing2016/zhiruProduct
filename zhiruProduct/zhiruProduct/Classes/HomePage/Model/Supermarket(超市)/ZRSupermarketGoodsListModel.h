//
//  ZRSupermarketGoodsListModel.h
//  zhiruProduct
//
//  Created by nanding on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  打折商品列表

#import <Foundation/Foundation.h>

@interface ZRSupermarketGoodsListModel : NSObject
//商品名称
@property (nonatomic, copy) NSString *goods_name;
//原价
@property (nonatomic, copy) NSString *old_price;
//物品id
@property (nonatomic, copy) NSString *goods_id;

//现价
@property (nonatomic, strong) NSNumber *now_price;
//图片地址
@property (nonatomic, copy) NSString *img_url;

//重量单位kg
@property (nonatomic, copy) NSString *weight;


///**
// 保存网络下载下来的图像
// */
//@property(nonatomic,strong)UIImage *cacheImg;


@end
