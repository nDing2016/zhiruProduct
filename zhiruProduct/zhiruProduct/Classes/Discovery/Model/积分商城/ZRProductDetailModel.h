//
//  ZRProductDetailModel.h
//  zhiruProduct
//
//  Created by nanding on 16/9/3.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRProductDetailModel : NSObject

////图片
//@property (nonatomic, copy) NSString *img;
//
////会员积分
//@property (nonatomic, copy) NSString *vipfraction;
//
////商品id
//@property (nonatomic, copy) NSString *commodityId;
//
////原积分
//@property (nonatomic, copy) NSString *fraction;
//
////名称
//@property (nonatomic, copy) NSString *commodityName;
//
////商品介绍
//@property (nonatomic, copy) NSString *commodityIntroduce;
//
////商品须知
//@property (nonatomic, copy) NSString *commodityNeed;
//
////兑换流程
//@property (nonatomic, copy) NSString *exchangeProcess;
//
////注意事项
//@property (nonatomic, copy) NSString *notice;


@property (nonatomic, copy) NSString *islogin;

@property (nonatomic, copy) NSString *myPoints;

@property (nonatomic, copy) NSString *fraction;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *vipfraction;

//0未下架1下架
@property (nonatomic, copy) NSString *state;

@end
