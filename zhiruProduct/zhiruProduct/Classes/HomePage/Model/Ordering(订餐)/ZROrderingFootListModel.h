//
//  ZROrderingFootListModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  菜品分类及菜品

#import <Foundation/Foundation.h>

@interface ZROrderingFootListModel : NSObject

/**
 *  是否是活动0不是1是"
 */
@property (nonatomic , copy) NSString * isPreferential;
/**
 *  分类标题
 */
@property (nonatomic , copy) NSString * categoryName;
/**
 *  "分类id"
 */
@property (nonatomic , copy) NSString * categoryId;
/**
 *  菜品列表
 */
@property (nonatomic , strong) NSArray * menu;


@end
