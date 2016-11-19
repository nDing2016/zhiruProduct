//
//  ZRTabBar.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/22.
//  Copyright © 2016年 Zhiru. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZRTabBar;
@protocol ZRTabBarDelegate <NSObject>

@optional
//点击普通按钮代理
- (void)tabBar:(ZRTabBar *)tabBar didClickBtn:(UIButton *)but;

@end


@interface ZRTabBar : UIView

/**
 *  保存 按钮的 tabBarItem
 */
@property (nonatomic , strong) NSArray * items;

@property (nonatomic , weak) id<ZRTabBarDelegate> delegate;

/**
 *  按钮集合
 */
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

/**
 *  普通按钮 保存选中的按钮
 */
@property (nonatomic, weak) UIButton *selectButton;


@end
