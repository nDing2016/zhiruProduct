//
//  ZROrderingMenuModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZROrderingMenuModel : NSObject
/**
 *  已售
 */
@property (nonatomic , copy) NSNumber * soldNum;
/**
 *  名称
 */
@property (nonatomic , copy) NSString * name;
/**
 *  价格
 */
@property (nonatomic , copy) NSNumber * unit_price;
/**
 *  菜品 id
 */
@property (nonatomic , copy) NSString * menu_id;
/**
 *  菜品图片
 */
@property (nonatomic , copy) NSString * menu_img;
@end
