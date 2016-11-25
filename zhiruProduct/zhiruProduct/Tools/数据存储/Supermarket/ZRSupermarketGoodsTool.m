//
//  ZRSupermarketGoodsTool.m
//  zhiruProduct
//
//  Created by nanding on 16/11/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketGoodsTool.h"


#define kSupermarketGoods [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"SupermarketAllGoods.txt"]

static  ZRSupermarketAllListModel*goodsListModel;
@implementation ZRSupermarketGoodsTool


+(BOOL)saveGoodsList:(ZRSupermarketAllListModel *)allListModel
{
    if ([self allGoodsListModel]) {
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        if ([defaultManager isDeletableFileAtPath:kSupermarketGoods]) {
            [defaultManager removeItemAtPath:kSupermarketGoods error:nil];
        }
    }
    BOOL state = [NSKeyedArchiver archiveRootObject:allListModel toFile:kSupermarketGoods];
    return state;
}

+(ZRSupermarketAllListModel *)allGoodsListModel
{
    goodsListModel = [NSKeyedUnarchiver unarchiveObjectWithFile:kSupermarketGoods];
    return goodsListModel;
}


@end
