//
//  UIView+ZRDraw.h
//  zhiruProduct
//
//  Created by nanding on 16/7/6.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZRDraw)
/**
 *  绘制文字
 *
 *  @param str   字符串
 *  @param font  字号
 *  @param color 颜色
 *  @param point 坐标点
 */
- (CGSize)drawWithStr:(NSString *)str Font:(UIFont *)font Color:(UIColor *)color Point:(CGPoint)point;


/**
 *  绘制图片
 *
 *  @param image image
 *  @param rect  rect
 */
- (void)drawImage:(UIImage *)image Rect:(CGRect)rect;

/**
 *  绘制直线
 *
 *  @param startPoint 起点
 *  @param endPoint   终点
 *  @param color      颜色
 */
- (void)drawLineStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color;


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


- (CGSize)drawWithStr:(NSString *)str Font:(UIFont *)font Color:(UIColor *)color Point:(CGPoint)point Size:(CGSize)size;




- (void)drawWithCircle:(UIColor *)color Rect:(CGRect)rect;

@end
