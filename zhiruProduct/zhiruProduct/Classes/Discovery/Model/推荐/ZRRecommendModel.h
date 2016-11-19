//
//  ZRRecommendModel.h
//  zhiruProduct
//
//  Created by nanding on 16/8/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRRecommendModel : NSObject

//分类图片地址
@property (nonatomic, copy) NSString *imgUrl;

//分类id
@property (nonatomic, copy) NSString *navId;

//分类名称
@property (nonatomic, copy) NSString *navName;

//分类下推荐团购列表 没有就是空
@property (nonatomic, strong) NSArray *groupList;

//请求地址
@property (nonatomic, copy) NSString *url;



@end
