//
//  ZCControl.h
//  Device
//
//  Created by ZhangCheng on 14-4-19.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//版本说明  iOS研究院 305044955
//使用此类，在工程pch文件里面加入该头文件，即可在工程内任意地方进行创建
//此类设计模式为最简单的工厂模式
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyControl : NSObject


/**
 *  文字button(无点击事件)
 *
 *  @param frame                     位置
 *  @param title                     标题
 *  @param size                      字号
 *  @param color                     颜色
 *  @param contentVerticalAlignment  垂直(分为上下)
 *  @param contentHorizontalAlignmen 水平(分为左右)
 *
 *  @return button
 */
+(UIButton*)createTitleButtonWithFrame:(CGRect)frame
                              andTitle:(NSString *)title
                               andFont:(NSInteger)size
                              andColor:(UIColor *)color
           andContentVerticalAlignment:
(UIControlContentVerticalAlignment)contentVerticalAlignment
         andContentHorizontalAlignment:
(UIControlContentHorizontalAlignment)contentHorizontalAlignment
;



+(UILabel *)createNavigationTitle:(NSString *)title;

+ (UIBarButtonItem *)buttonWithTarget:(id)theTarget action:(SEL)theAction title:(NSString *)title left:(BOOL) isLeft;


//屏幕适配等比放大
+(CGRect)createCGRectMakeScale:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height;
+(CGPoint)createCGPointMakeScale:(CGFloat)x andY:(CGFloat)y;
+(CGSize)createCGSizeMakeScale:(CGFloat)width andHeight:(CGFloat)height;

#pragma mark --创建数据模型
+(void)createModelFromDictionary:(NSDictionary *)dict className:(NSString *)className;

#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(NSInteger)font Text:(NSString*)text color:(UIColor*)color textAlignment:(NSTextAlignment)textAlignment numberLines:(NSInteger)num;
#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame;
#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(UIImage*)image;

#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;
#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font;

//适配器的方法  扩展性方法
//现有方法，已经在工程里面存在，如果修改工程内所有方法，工作量巨大，就需要使用适配器的方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName;
#pragma mark 创建UIScrollView
+(UIScrollView*)makeScrollViewWithFrame:(CGRect)frame andSize:(CGSize)size;
+(UIScrollView *)createUIScrollViewWithFrame:(CGRect)frame contentSize:(CGSize)size pagingEnabled:(BOOL)pagingEnabled showsHorizontalScrollIndicator:(BOOL)showsHorizontalScrollIndicator showsVerticalScrollIndicator:(BOOL)showsVerticalScrollIndicator delegate:(id)delegate;
#pragma mark 创建UIPageControl
+(UIPageControl*)makePageControlWithFram:(CGRect)frame;
#pragma mark 创建UISlider
+(UISlider*)makeSliderWithFrame:(CGRect)rect AndImage:(UIImage*)image;
#pragma mark 创建时间转换字符串
+(NSString *)stringFromDateWithHourAndMinute:(NSDate *)date;
#pragma mark --判断导航的高度64or44
+(float)isIOS7;

#pragma mark 内涵图需要的方法
+ (NSString *)stringDateWithTimeInterval:(NSString *)timeInterval;

+ (CGFloat)textHeightWithString:(NSString *)text width:(CGFloat)width fontSize:(NSInteger)fontSize;

+ (NSString *)addOneByIntegerString:(NSString *)integerString;
//#pragma mark --判断设备型号
//+(NSString *)platformString;

@end