//
//  ZRNavModel.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/8.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRNavModel : NSObject
/**
 *  导航图名字 例:丽人,团购
 */
@property (nonatomic , copy) NSString * nav_name;
/**
 *  请求地址
 */
@property (nonatomic , copy) NSString * url;
/**
 *  图片url
 */
@property (nonatomic , copy) NSString * img_url;
/**
 *  id
 */
@property (nonatomic , copy) NSString * nav_id;

@end
