//
//  ZRSearchView.h
//  zhiruProduct
//
//  Created by 魏嘉楠 on 16/6/29.
//  Copyright © 2016年 Zhiru. All rights reserved.
//  自定义首页上方 搜索条

#import <UIKit/UIKit.h>

@interface ZRSearchView : UIView

//点击搜索条回调
@property (nonatomic , copy)void (^clickSearchView)();
//搜索条背景
@property (nonatomic , weak) UIView *textBg;
@end
