//
//  NSString+ZRString.m
//  zhiruProduct
//
//  Created by nanding on 16/7/4.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "NSString+ZRString.h"

@implementation NSString (ZRString)
/**
 *  获取字符串size
 *
 *  @param string  字符串
 *  @param font    字号
 *  @param maxSize 最大size
 *
 *  @return 该字符串的size
 */
+ (CGSize)getSize:(NSString *)string strFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    
    //NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil, NSForegroundColorAttributeName,nil];
    //NSMutableAttributedString *str =[[NSMutableAttributedString alloc] initWithString:string attributes:attributesDictionary];
    //CGSize size1 = [string boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil].size;

    
    
    
//    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil, NSForegroundColorAttributeName,nil];
//    CGSize size1 = [string boundingRectWithSize:maxSize
//                                        options:NSStringDrawingTruncatesLastVisibleLine
//                                     attributes:attributesDictionary
//                                        context:nil].size;
    
    
    
   
    
//    CGRect screen = [UIScreen mainScreen].bounds;
//    CGFloat maxWidth = screen.size.width;
//    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    
    
    
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
        
        CGRect rect = [string boundingRectWithSize:maxSize
                                           options:opts
                                        attributes:attributes
                                           context:nil];
        textSize = rect.size;
        

    }
    
    
    
    return textSize;
}


@end
