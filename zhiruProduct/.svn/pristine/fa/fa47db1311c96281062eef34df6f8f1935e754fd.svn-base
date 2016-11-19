//
//  ZRSupermarketHomeObj.h
//  zhiruProduct
//
//  Created by nanding on 16/7/12.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, isFirst) {
    Seledted,
    NonSelected
    
};


@interface ZRSupermarketHomeObj : NSObject

+(instancetype)shareInstance;


@property (nonatomic, strong) NSMutableDictionary *shoppingCarDic;

//总价
@property (nonatomic, assign) CGFloat allPrice;

//总数
@property (nonatomic, assign) NSInteger allNumber;



@property (nonatomic, strong) NSMutableArray *allProductsArray;





#pragma mark - 订餐
@property (nonatomic, strong) NSMutableArray *selectedFoodsArray;

//总价
@property (nonatomic, assign) CGFloat totalPrice;

//总数
@property (nonatomic, assign) NSInteger totalNumber;

@property (nonatomic, assign) isFirst isfirst;

//添加
-(isFirst)comparewithObject:(NSObject *)object productArr:(NSArray *)product;


//获取某行的添加内容
-(NSMutableArray *)getProductsArr:(NSObject *)model;

//替换某行的内容
-(void)replaceProducts:(NSMutableArray *)products withObject:(NSObject *)object;

//获得总钱数
-(CGFloat)getPrductsMoneyCount;

@end
