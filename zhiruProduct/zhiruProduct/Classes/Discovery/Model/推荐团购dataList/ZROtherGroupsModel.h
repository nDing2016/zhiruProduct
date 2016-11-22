//
//  ZROtherGroupsModel.h
//  zhiruProduct
//
//  Created by nanding on 16/8/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZROtherGroupsModel : NSObject

//团购Id
@property (nonatomic, copy) NSString *group_id;

//团购名称
@property (nonatomic, copy) NSString *group_name;

//价格
@property (nonatomic, copy) NSString *now_price;

//已售
@property (nonatomic, copy) NSString *sold_num;

//团购图片
@property (nonatomic, copy) NSString *group_img;






@end
