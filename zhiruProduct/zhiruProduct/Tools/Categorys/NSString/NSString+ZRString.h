//
//  NSString+ZRString.h
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZRString)

/**
 *  获取字符串size
 *
 *  @param string  字符串
 *  @param font    字号
 *  @param maxSize 最大size
 *
 *  @return 该字符串的size
 */
+ (CGSize)getSize:(NSString *)string strFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end
