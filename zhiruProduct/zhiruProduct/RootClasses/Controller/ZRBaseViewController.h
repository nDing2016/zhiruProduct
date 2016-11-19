//
//  ZRBaseViewController.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/23.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRBaseViewController : UIViewController

/**
 *  左按钮回调
 */
@property (nonatomic,copy) void(^baseLeftBtnClick)();
/**
 *  右按钮回调
 */
@property (nonatomic,copy) void(^baseRightBtnClick)();

/**
 *  设置nav 标题及左右按钮图标和点击事件
 *
 *  @param title      nav标题
 *  @param leftImg    左按钮图片
 *  @param leftTitle  左按钮标题
 *  @param rightImg   右按钮图片
 *  @param RightTitle 右按钮标题
 *  @param leftClick  左点击事件
 *  @param rightClick 右点击事件
 */
- (void)createNavWithTitle: (NSString *)title
                andLeftImg: (NSString *)leftImg
              andLeftTitle: (NSString *)leftTitle
               andRightImg: (NSString *)rightImg
             andRightTitle: (NSString *)RightTitle
              andLeftClick: (void(^)()) leftClick
             andRightTitle: (void(^)()) rightClick;



@end
