//
//  NSDictionary+ZRGetDatas.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/8/31.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRHomeNavModel.h"
@interface NSDictionary (ZRGetDatas)

+ (NSDictionary *)dictionaryGetScreeningWithModel :(ZRHomeNavModel *)model isPaixu :(BOOL)ispai;

@end
