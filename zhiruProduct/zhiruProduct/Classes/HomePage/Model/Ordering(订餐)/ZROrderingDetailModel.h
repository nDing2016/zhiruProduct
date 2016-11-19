//
//  ZROrderingDetailModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/24.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  订餐详情

#import <Foundation/Foundation.h>
#import "ZROrderingBusinessMsgModel.h"
@interface ZROrderingDetailModel : NSObject
/**
 *  菜品分类,菜品列表
 */
@property (nonatomic , strong) NSArray * footList;
/**
 *  评论列表
 */
@property (nonatomic , strong) NSArray * commentList;
/**
 *  店铺信息 
 */
@property (nonatomic , strong) ZROrderingBusinessMsgModel * businessMsg;



@end
