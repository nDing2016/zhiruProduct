//
//  UINavigationBar+ZRAwesome.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ZRAwesome)
// 设置背景颜色
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
// 设置元素透明度
- (void)lt_setElementsAlpha:(CGFloat)alpha;
// 设置形变的高度
- (void)lt_setTranslationY:(CGFloat)translationY;
// 重设
- (void)lt_reset ;
@end
