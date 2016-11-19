//
//  ZRStringWithLabel.m
//  zhiruProduct
//
//  Created by pj on 16/7/9.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "ZRStringWithLabel.h"

@implementation ZRStringWithLabel


+ (CGFloat)returanHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font
{
    CGSize size = CGSizeMake(width, 10000);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}
+ (CGFloat)returanWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font
{
    CGSize size = CGSizeMake(3000, height);
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}
@end
