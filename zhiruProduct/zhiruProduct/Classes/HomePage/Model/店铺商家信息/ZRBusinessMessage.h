//
//  ZRBusinessMessage.h
//  zhiruProduct
//
//  Created by nanding on 16/7/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRBusinessMessage : NSObject

//店铺（商家）id
@property (nonatomic, copy) NSString *business_id;

//店铺（商家）名称，eg：汉堡王
@property (nonatomic, copy) NSString *business_msg_name;

//距离
@property (nonatomic, copy) NSString *distance;

//店铺（商家）图片
@property (nonatomic, copy) NSString *img_url;

//店铺（商家）星级
@property (nonatomic, copy) NSString *business_comment_grade;

//是否支持外卖默认是0不支持1:支持
@property (nonatomic, copy) NSString *is_pack;

//是否支持团购默认是0不支持1:支持
@property (nonatomic, copy) NSString *is_group;

//分类标签数据
@property (nonatomic, copy) NSString *nav_name;





@end
