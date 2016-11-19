//
//  UIView+ZRDraw.m
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import "UIView+ZRDraw.h"

@implementation UIView (ZRDraw)
/**
 *  绘制文字
 *
 *  @param str   字符串
 *  @param font  字号
 *  @param color 颜色
 *  @param point 坐标点
 */
- (CGSize)drawWithStr:(NSString *)str Font:(UIFont *)font Color:(UIColor *)color Point:(CGPoint)point
{
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    NSDictionary* attribute1 = @{
                                 NSForegroundColorAttributeName:color,//设置文字颜色
                                 NSFontAttributeName:font,//设置文字的字体
                                 NSParagraphStyleAttributeName:paragraphStyle,//设置文字的样式
                                 };
    
    CGSize size1 = CGSizeZero;
    if ([str respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        size1 = [str boundingRectWithSize:self.bounds.size
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{
                                                   NSFontAttributeName:font,//设置文字的字体
                                                   NSKernAttributeName:@0,//文字之间的字距
                                                   }
                                         context:nil].size;
    }
    
    
    
    CGRect rect1 = CGRectMake(point.x, point.y, size1.width, size1.height);
    
    if ([str respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        [str drawInRect:rect1 withAttributes:attribute1];
    }
    
    
    

    
    return size1;
    
}


- (CGSize)drawWithStr:(NSString *)str Font:(UIFont *)font Color:(UIColor *)color Point:(CGPoint)point Size:(CGSize)size
{
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    //paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    NSDictionary* attribute1 = @{
                                 NSForegroundColorAttributeName:color,//设置文字颜色
                                 NSFontAttributeName:font,//设置文字的字体
                                 NSParagraphStyleAttributeName:paragraphStyle,//设置文字的样式
                                 };
    CGSize size1 = [str boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                               NSFontAttributeName:font,//设置文字的字体
                                               NSKernAttributeName:@0,//文字之间的字距
                                               }
                                     context:nil].size;
    CGRect rect1 = CGRectMake(point.x, point.y, size1.width, size1.height);
    [str drawInRect:rect1 withAttributes:attribute1];
    
    
    
    
    return size1;
    
}



/**
 *  绘制图片
 *
 *  @param image image
 *  @param rect  rect
 */
- (void)drawImage:(UIImage *)image Rect:(CGRect)rect
{
    [image drawInRect:rect];
}


/**
 *  绘制直线
 *
 *  @param startPoint 起点
 *  @param endPoint   终点
 *  @param color      颜色
 */
- (void)drawLineStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x,endPoint.y);
    CGContextStrokePath(context);
}




/**
 *  绘制长方形
 *
 *  @param point1 左上角
 *  @param point2 右上角
 *  @param point3 右下角
 *  @param point4 左下角
 *  @param color  背景色
 *  @param alpha  透明度
 */
- (void)drawRectangleWithPoint1:(CGPoint)point1 Point2:(CGPoint)point2 Point3:(CGPoint)point3 Point4:(CGPoint)point4 Color:(CGFloat)r G:(CGFloat)g B:(CGFloat)b Alpha:(float)alpha;
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, point1.x,point1.y);
    CGContextAddLineToPoint(context, point2.x,point2.y);
    CGContextAddLineToPoint(context, point3.x,point3.y);
    CGContextAddLineToPoint(context, point4.x,point4.y);
    CGContextAddLineToPoint(context, point1.x,point1.y);
    CGContextSetRGBFillColor(context, r, g, b, alpha);
    CGContextFillPath(context);

}


/**
 *  绘制圆
 *
 *  @param color
 *  @param rect  
 */
- (void)drawWithCircle:(UIColor *)color Rect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *aColor = color;
    //CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
    CGContextSetFillColorWithColor(context, aColor.CGColor);
    
    CGContextFillEllipseInRect(context, rect);
}


@end
