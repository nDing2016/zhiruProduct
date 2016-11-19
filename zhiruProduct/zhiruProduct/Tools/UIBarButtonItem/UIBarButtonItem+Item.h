//
//  UIBarButtonItem+Item.h
//  TourismRaise
//
//  Created by 魏嘉楠 on 16/4/19.
//  Copyright © 2016年 zhangdi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)
/**
 *  创建navigation左右按钮
 *
 *  @param image     图片
 *  @param highImage 高亮图片
 *  @param target    self
 *  @param action    点击方法
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
@end
