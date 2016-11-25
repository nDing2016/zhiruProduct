//
//  ZRSupermarketAllListModel.m
//  zhiruProduct
//
//  Created by nanding on 16/11/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRSupermarketAllListModel.h"
#import "ZRSupermarketProductsListModel.h"


#define kLongitude          @"kLongitude"
#define kLatitude           @"kLatitude"
#define kGoodsListArr       @"kGoodsListArr"


@implementation ZRSupermarketAllListModel

//+(NSDictionary *)mj_objectClassInArray
//{
//    return @{@"list":[ZRSupermarketProductsListModel class]};
//}



// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_latitude forKey:kLatitude];
    [aCoder encodeObject:_longitude forKey:kLongitude];
    [aCoder encodeObject:_list forKey:kGoodsListArr];
    
}

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        // 一定要记得赋值
        
        _longitude = [aDecoder decodeObjectForKey:kLongitude];
        _latitude = [aDecoder decodeObjectForKey:kLatitude];
        _list = [aDecoder decodeObjectForKey:kGoodsListArr];
       
        
    }
    return self;
}






@end
