//
//  ZRMessageModel.h
//  zhiruProduct
//
//  Created by pj on 16/11/17.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRMessageModel : NSObject

// 标题
@property (nonatomic, copy)NSString * title;
// 内容
@property (nonatomic, copy)NSString * content;
// 创建时间
@property (nonatomic, copy)NSString * create_time;
// 0未读 1已读
@property (nonatomic, copy)NSString * is_read;

@end
