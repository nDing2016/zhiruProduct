//
//  ZRSupermarketAllListModel.h
//  zhiruProduct
//
//  Created by nanding on 16/11/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRSupermarketAllListModel : NSObject <NSCoding>

//经度
@property (nonatomic, copy) NSString *longitude;
//纬度
@property (nonatomic, copy) NSString *latitude;


@property (nonatomic, strong) NSArray *list;

@end
