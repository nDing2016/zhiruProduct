//
//  ZRSupermarketGoodsTool.h
//  zhiruProduct
//
//  Created by nanding on 16/11/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZRSupermarketAllListModel;
@interface ZRSupermarketGoodsTool : NSObject


+(BOOL)saveGoodsList:(ZRSupermarketAllListModel *)allListModel;

+(ZRSupermarketAllListModel *)allGoodsListModel;






@end
